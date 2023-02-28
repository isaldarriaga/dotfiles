# If not running interactively, don't do anything
[[ $- != *i* ]] && return

STARSHIP=$(which starship)
# Load starship prompt if starship is installed
if  [ -n $STARSHIP ]; then
    __main() {
        local major="${BASH_VERSINFO[0]}"
        local minor="${BASH_VERSINFO[1]}"

        if ((major > 4)) || { ((major == 4)) && ((minor >= 1)); }; then
            source <("$STARSHIP" init bash --print-full-init)
        else
            source /dev/stdin <<<"$("$STARSHIP" init bash --print-full-init)"
        fi
    }
    __main
    unset -f __main
fi

export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Replace ls with exa
alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
alias la='exa -al --color=always --group-directories-first --icons'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons'  # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l.="exa -a | egrep '^\.'"                                     # show only dotfiles
alias ip="ip -color"

# Aliases
alias dir='dir --color=auto'
alias egrep='grep -E --color=auto'
alias fgrep='grep -F --color=auto'
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias grep='grep --color=auto'
alias grubup="sudo update-grub"
alias hw='hwinfo --short'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias psmem='ps auxf | sort -nr -k 4'
alias rmpkg="sudo pacman -Rdd"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias upd='/usr/bin/update'
alias vdir='vdir --color=auto'
alias wget='wget -c '

# Help people new to Arch
alias apt-get='man pacman'
alias apt='man pacman'
alias helpme='cht.sh --shell'
alias please='sudo'
alias tb='nc termbin.com 9999'

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns `pacman -Qtdq`'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# ---------------------------------------------------

#k3s
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

# my editor
export EDITOR=helix
export VISUAL=helix

# my aliases
#alias pac="sudo pacman"

#alias search="yay -Ss"
alias sync="sudo nixos-rebuild switch"
#alias upgrade="yay -Su"
#alias remove="yay -Rns"

#alias mk="minikube"
alias k="sudo k3s kubectl"

alias pm="podman"
alias db="distrobox"

#alias hx="helix"

alias lg="lazygit"
alias gu="gitui"

alias tree="xplr"

#if status --is-interactive && type -q fastfetch
#   fastfetch --load-config dr460nized
#end

typeracer

neofetch
