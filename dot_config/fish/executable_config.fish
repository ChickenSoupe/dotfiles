source /usr/share/cachyos-fish-config/cachyos-config.fish

# Commands to run in interactive sessions can go here
if status is-interactive
    # No greeting
    set fish_greeting

    # Use starship
    function starship_transient_prompt_func
        starship module character
    end
    if test "$TERM" != linux
        starship init fish | source
        enable_transience
    end

    # Colors
    # if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    #     cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    # end
end

alias ls 'eza -l --color=always --group-directories-first --icons'
alias clear "printf '\033[2J\033[3J\033[1;1H'"
alias update='sudo cachyos-rate-mirrors && paru'
alias paruf="paru -Slq | grep -aE '^[a-zA-Z0-9_.+-]+\$' | fzf --multi --layout=reverse --ansi --preview 'paru -Sii {1}' --preview-window=down:75% --bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' | xargs -ro paru -S"
alias yayf "yay -Slq | strings | grep -E '^[a-zA-Z0-9_.+-]+\$' | fzf --multi --layout=reverse --ansi --preview 'yay -Sii {1}' --preview-window=down:75% --bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' | xargs -ro yay -S"
alias zim 'nvim (zi)'

#function fish_prompt
#  set_color cyan; echo (pwd)
#  set_color green; echo '> '
# end

#Yazi
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
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
    if not pgrep -f ssh-agent >/dev/null
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
    if jq . "$file" >"$tmp"
        mv "$tmp" "$file"
        echo "Formatted and saved '$file'"
    else
        echo "jq parse error — file not modified"
        rm -f "$tmp"
        return 1
    end
end
# set -g fish_term24bit 0
zoxide init fish | source
