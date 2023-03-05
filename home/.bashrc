# If not running interactively, don't do anything
[[ $- != *i* ]] && return

case $(tty) in /dev/tty[0-9]*)
  setfont -d
  showconsolefont
esac

if [ $(basename $SHELL) = "bash" ]; then
  eval "$(starship init bash)"
elif [ $(basename $SHELL) = "fish" ]; then
  starship init fish | source  
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
alias egrep='grep -E --color=auto'
alias fgrep='grep -F --color=auto'
alias grep='grep --color=auto'
alias grubup="sudo update-grub"
alias hw='hwinfo --short'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias psmem='ps auxf | sort -nr -k 4'
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# ---------------------------------------------------

#k3s
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

# my editor
export EDITOR=helix
export VISUAL=helix

# my aliases
#alias pac="sudo pacman"

alias search="nix-env -qaP"
alias shell="nix-shell -p"
alias repl="nix repl --extra-experimental-features 'flakes repl-flake' nixpkgs"
alias rf="repl"
alias sync="sudo nixos-rebuild switch"
alias test="sudo nixos-rebuild test"
alias gc="nix-collect-garbage"
alias listgen="sudo nix-env --profile /nix/var/nix/profiles/system --list-generations"
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
alias warmup="typeracer"

#if status --is-interactive && type -q fastfetch
#   fastfetch --load-config dr460nized
#end

cd ~/repos && la && pwd

