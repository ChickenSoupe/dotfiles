local function fail(s, ...)
  ya.notify { title = "Command Palette", content = string.format(s, ...), timeout = 5, level = "error" }
end

local function info(s, ...)
  ya.notify { title = "Command Palette", content = string.format(s, ...), timeout = 3, level = "info" }
end

-- Get all TOML files from plugins directory
local function get_plugin_tomls()
  local tomls = {}
  local plugins_dir = os.getenv("HOME") .. "/.config/yazi/plugins"

  -- Try to list directory contents
  local handle = io.popen("find '" .. plugins_dir .. "' -name '*.toml' 2>/dev/null")
  if handle then
    for line in handle:lines() do
      table.insert(tomls, line)
    end
    handle:close()
  end

  return tomls
end

-- Parse TOML keymap file to extract keybindings (supports both old and new formats)
local function parse_keymap_file(file_path)
  local commands = {}

  -- Read file content
  local file = io.open(file_path, "r")
  if not file then
    return commands
  end

  local content = file:read("*all")
  file:close()

  -- Parse OLD format: [[mgr.prepend_keymap]] or [[manager.prepend_keymap]] or [[input.prepend_keymap]]
  local current_entry = {}
  local in_prepend = false

  for line in content:gmatch("[^\r\n]+") do
    line = line:gsub("^%s*", ""):gsub("%s*$", "") -- trim whitespace

    -- Check for section headers like [[mgr.prepend_keymap]] or [[manager.prepend_keymap]]
    if line:match("^%[%[.*%.prepend_keymap%]%]") then
      -- Save previous entry if complete
      if current_entry.key and current_entry.run then
        table.insert(commands, current_entry)
      end
      -- Start new entry
      current_entry = {}
      in_prepend = true
    elseif line:match("^%[%[") then
      -- Different section started, save current entry and stop
      if current_entry.key and current_entry.run then
        table.insert(commands, current_entry)
      end
      current_entry = {}
      in_prepend = false
    elseif in_prepend and line ~= "" then
      -- Parse key binding
      local key_match = line:match('^on%s*=%s*"([^"]*)"')
      if key_match then
        current_entry.key = key_match
      else
        local key_array = line:match('^on%s*=%s*%[([^%]]*)%]')
        if key_array then
          local keys = {}
          for k in key_array:gmatch('"([^"]*)"') do
            table.insert(keys, k)
          end
          current_entry.key = table.concat(keys, ", ")
        end
      end

      -- Parse description
      local desc_match = line:match('^desc%s*=%s*"([^"]*)"')
      if desc_match then
        current_entry.desc = desc_match
      end

      -- Parse run command
      local run_match = line:match('^run%s*=%s*"([^"]*)"')
      if run_match then
        current_entry.run = run_match
      else
        local run_array = line:match('^run%s*=%s*%[([^%]]*)')
        if run_array then
          local cmds = {}
          for r in run_array:gmatch('"([^"]*)"') do
            table.insert(cmds, r)
          end
          if #cmds > 0 then
            current_entry.run = cmds[1]
          end
        end
      end
      
      -- Skip 'for' field - we don't need it for command palette
    end
  end

  -- Don't forget the last entry
  if current_entry.key and current_entry.run then
    table.insert(commands, current_entry)
  end

  -- Parse NEW inline array format: { on = "key", run = "cmd", desc = "description" }
  -- This works for both [manager] keymap = [...] and prepend_keymap = [...]
  for entry in content:gmatch("%{[^}]+%}") do
    local cmd = {}
    
    -- Parse 'on' field (key binding)
    local on_str = entry:match('on%s*=%s*"([^"]*)"')
    if on_str then
      cmd.key = on_str
    else
      -- Handle array format: on = ["g", "g"]
      local on_array = entry:match('on%s*=%s*%[([^%]]+)%]')
      if on_array then
        local keys = {}
        for k in on_array:gmatch('"([^"]*)"') do
          table.insert(keys, k)
        end
        cmd.key = table.concat(keys, ", ")
      end
    end
    
    -- Parse 'desc' field
    local desc = entry:match('desc%s*=%s*"([^"]*)"')
    if desc then
      cmd.desc = desc
    end
    
    -- Parse 'run' field
    local run_str = entry:match('run%s*=%s*"([^"]*)"')
    if run_str then
      cmd.run = run_str
    else
      -- Handle array format: run = ["cmd1", "cmd2"]
      local run_array = entry:match('run%s*=%s*%[([^%]]+)%]')
      if run_array then
        local cmds = {}
        for r in run_array:gmatch('"([^"]*)"') do
          table.insert(cmds, r)
        end
        if #cmds > 0 then
          cmd.run = cmds[1]
        end
      end
    end
    
    -- Only add if we have both key and run command
    if cmd.key and cmd.run then
      table.insert(commands, cmd)
    end
  end

  return commands
end

-- Get all available commands from keymap files
local function get_all_commands()
  local commands = {}

  -- Try to read from config keymap
  local config_path = os.getenv("HOME") .. "/.config/yazi/keymap.toml"
  local config_commands = parse_keymap_file(config_path)

  for _, cmd in ipairs(config_commands) do
    cmd.source = "config"
    table.insert(commands, cmd)
  end

  -- Try to read from plugin TOML files
  local plugin_tomls = get_plugin_tomls()
  for _, toml_path in ipairs(plugin_tomls) do
    local plugin_commands = parse_keymap_file(toml_path)
    for _, cmd in ipairs(plugin_commands) do
      cmd.source = "plugin:" .. toml_path:match("([^/]+)$")
      table.insert(commands, cmd)
    end
  end

  return commands
end

-- Create fuzzy searchable command palette using fzf
local function show_command_palette()
  local commands = get_all_commands()

  if #commands == 0 then
    fail("No commands found in keymap files")
    return
  end

  -- Build input for fzf
  local input_lines = {}
  for _, cmd in ipairs(commands) do
    local desc = cmd.desc or "No description"
    local key_display = cmd.key or "No key"
    local line = string.format("%s\t%s\t%s", desc, key_display, cmd.run)
    table.insert(input_lines, line)
  end
  
  local input_text = table.concat(input_lines, "\n")

  local permit = ui.hide()
  
  -- Spawn fzf
  local child, err = Command("fzf")
    :arg({
      "--height=80%",
      "--layout=reverse",
      "--border",
      "--prompt=🔍 Command Palette: ",
      "--header=Type to search commands",
      "--preview-window=right:40%",
      "--preview=echo {3}",
      "--delimiter=\t",
      "--with-nth=1,2",
      "--bind=ctrl-/:toggle-preview"
    })
    :stdin(Command.PIPED)
    :stdout(Command.PIPED)
    :stderr(Command.INHERIT)
    :spawn()
  
  if not child then
    permit:drop()
    fail("Failed to spawn fzf. Is it installed?")
    return
  end

  -- Write all input to stdin
  local write_status, write_err = child:write_all(input_text)
  
  if not write_status then
    permit:drop()
    fail("Failed to write to fzf: " .. tostring(write_err))
    return
  end
  
  -- Flush the stdin buffer
  local flush_status, flush_err = child:flush()
  
  if not flush_status then
    permit:drop()
    fail("Failed to flush stdin: " .. tostring(flush_err))
    return
  end

  -- Wait for fzf to complete - this consumes the child and closes stdin
  local output, wait_err = child:wait_with_output()

  if not output then
    permit:drop()
    fail("Cannot read fzf output")
    return
  end

  -- Exit code 130 means user pressed Ctrl+C (cancelled)
  if not output.status.success and output.status.code ~= 130 then
    permit:drop()
    fail("fzf exited with error code: " .. tostring(output.status.code))
    return
  end

  -- Parse fzf output
  local selected_line = output.stdout:match("([^\n]*)")
  if not selected_line or selected_line == "" then
    permit:drop()
    return
  end
  
  -- Drop permit before executing command to restore UI
  permit:drop()

  local desc, key, run_cmd = selected_line:match("([^\t]*)\t([^\t]*)\t([^\t]*)")
  if run_cmd then
    info("Executing: " .. desc)
    
    -- Parse command and arguments
    local parts = {}
    for part in run_cmd:gmatch("%S+") do
      table.insert(parts, part)
    end
    
    if #parts == 0 then
      return
    end
    
    local cmd = parts[1]
    table.remove(parts, 1)
    
    -- Execute command using ya.emit
    ya.emit(cmd, parts)
  end
end

-- Alternative built-in interface (fallback if fzf not available)
local function show_builtin_palette()
  local commands = get_all_commands()

  if #commands == 0 then
    fail("No commands found in keymap files")
    return
  end

  -- Create candidates for ya.which with single character keys
  local candidates = {}
  local keys = "abcdefghijklmnopqrstuvwxyz0123456789"

  for i, cmd in ipairs(commands) do
    if i > #keys then break end -- Limit to available keys

    local desc = cmd.desc or "No description"
    local key_display = cmd.key or "No key"
    local display = string.format("%s (%s)", desc, key_display)

    table.insert(candidates, {
      on = keys:sub(i, i),
      desc = display,
      cmd = cmd.run,
      key = cmd.key
    })
  end

  -- Show the selection interface
  local choice = ya.which {
    cands = candidates,
    silent = true
  }

  if choice then
    local selected = candidates[choice]
    info("Executing: " .. (selected.desc or "Unknown command"))
    
    -- Parse command and arguments
    local parts = {}
    for part in selected.cmd:gmatch("%S+") do
      table.insert(parts, part)
    end
    
    if #parts > 0 then
      local cmd = parts[1]
      table.remove(parts, 1)
      ya.emit(cmd, parts)
    end
  end
end

return {
  entry = function(_, args)
    local use_builtin = args and args[1] == "builtin"

    if use_builtin then
      show_builtin_palette()
    else
      show_command_palette()
    end
  end,
}
