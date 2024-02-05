# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Replace ls with exa
LS='exa -al --color=always --group-directories-first' # preferred listing
LA='exa -al --color=always --group-directories-first' # all files and dirs
LL='exa -l --color=always --group-directories-first --icons' # long format
LT='exa -aT --color=always --group-directories-first --icons' # tree listing
LDOT="exa -a | egrep '^\.'" # only dot files

case $(tty) in /dev/tty[0-9]*)
  echo "tty detected!"
  setfont -d
  showconsolefont

  alias ls="$LS"
  alias la="$LA"
  alias ll="$LL"
  alias lt="$LT"
  alias l.="$LDOT"
esac

case $(tty) in /dev/pts/[0-9]*)
  if [ $(basename $SHELL) = "bash" ]; then
    eval "$(starship init bash)"
  elif [ $(basename $SHELL) = "fish" ]; then
    starship init fish | source  
  fi
  export STARSHIP_CONFIG=~/.config/starship/starship.toml

  alias ls="$LS --icons"
  alias la="$LA --icons"
  alias ll="$LL --icons"
  alias lt="$LT --icons"
  alias l.="$LDOT"
esac

echo -e -n "\x1b[\x33 q" # Blinking underline
# man coloring
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Aliases
alias ip="ip -color"
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
alias less="less --use-color"

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"
alias journalctl="jctl"

# ---------------------------------------------------

# k3s
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

# my editor
export EDITOR=hx
export VISUAL=hx

# ALIASES

# nix lifecycle
#export NIXPKGS_ALLOW_UNFREE=1
#alias search="nix-env -qaP"
#alias try="nix-shell -p"
#alias dry="nix-env --dry-run"
#alias install="nix-env -iA"
#alias upgrade="nix-env --upgrade"
#alias remove="nix-env --uninstall"
#alias uninstall="remove"
#alias listgen="sudo nix-env --profile /nix/var/nix/profiles/system --list-generations"
#alias gc="nix-collect-garbage"

# nix language
#alias repl="nix repl --extra-experimental-features 'flakes repl-flake' nixpkgs"

# nixos specific
#alias sync="sudo nixos-rebuild switch"
#alias test="sudo nixos-rebuild test"

# containers
alias mk="minikube"
alias k="sudo k3s kubectl"

alias pm="podman"
alias db="distrobox"

# git

alias lg="lazygit"
alias gu="gitui"

# other

alias tree="xplr"
alias warmup="typeracer"

la

# Advanced command-not-found hook
if [ -f /etc/arch-release ]; then
  source /usr/share/doc/find-the-command/ftc.bash
fi

if [ -f ~/.start-ide.sh ]; then
  if [ -z $(pgrep java) ]; then
    ~/.start-ide.sh
  else
    printf "\n\tWebstorm is running already\n"
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
