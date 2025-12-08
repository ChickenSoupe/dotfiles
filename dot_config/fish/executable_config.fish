source ~/.config/fish/functions/ideapadslim5.fish
source /usr/share/cachyos-fish-config/cachyos-config.fish


function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

#function fish_prompt
#    echo "acidhub > "
#end

if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting

end

starship init fish | source
if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
end

alias pamcan pacman
alias ls 'eza -l --color=always --group-directories-first --icons'
alias clear "printf '\033[2J\033[3J\033[1;1H'"
# alias q 'qs -c ii'
alias update='sudo cachyos-rate-mirrors && paru'    

#function fish_prompt
#  set_color cyan; echo (pwd)
#  set_color green; echo '> '
# end

#Yazi
function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

function history
    builtin history --show-time='%F %T '
end

#if test -z (pgrep ssh-agent | string collect)
#    eval (ssh-agent -c)
#    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
#    set -Ux SSH_AGENT_PID $SSH_AGENT_PID
#end
# ssh-add ~/.ssh/id_ed25519

function ssh-start
    if not pgrep -f ssh-agent > /dev/null
        eval (ssh-agent -c)
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
        set -Ux SSH_AGENT_PID $SSH_AGENT_PID
    end
    ssh-add ~/.ssh/id_ed25519
end


function prettyjson
    if test (count $argv) -ne 1
        echo "Usage: prettyjson <file.json>"
        return 1
    end

    set file $argv[1]
    if not test -f $file
        echo "Error: file '$file' does not exist"
        return 1
    end

    # Format via jq, writing to a temp file
    set tmp "$file.tmp"
    # Run jq and capture only if success
    if jq . "$file" > "$tmp"
        mv "$tmp" "$file"
        echo "Formatted and saved '$file'"
    else
        echo "jq parse error — file not modified"
        rm -f "$tmp"
        return 1
    end
end

