# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ==========================
# paths used in this session
# ==========================

PATH_HOME="/home/$USER"

# hidden folders
PATH_HOME_BASHRC="$PATH_HOME/.bashrc"
PATH_HOME_CACHE="$PATH_HOME/.cache"
PATH_HOME_CONFIG="$PATH_HOME/.config"
PATH_HOME_LOCAL="$PATH_HOME/.local"
PATH_HOME_LOCAL_STATE="$PATH_HOME_LOCAL/state"
PATH_HOME_LOCAL_SHARE="$PATH_HOME_LOCAL/share"
PATH_HOME_CARGO="$HOME/.cargo"

# repos
PATH_REPOS="$PATH_HOME/repos"
PATH_REPOS_DOTFILES="$PATH_REPOS/dotfiles"
PATH_REPOS_HELIX_IS="$PATH_REPOS/helixis"
PATH_REPOS_WEB="$PATH_REPOS/web"
PATH_REPOS_API="$PATH_REPOS/api"

PATH_REPOS_DOTFILES_CONFIG="$PATH_REPOS_DOTFILES/config"

# ==============
# setup defaults
# ==============

# actions

ACTION_BACKUP="BACKUP"
ACTION_INSTALL="INSTALL"
ACTION_LINK="LINK"

# editors

EDITOR_HELIX="HELIX-EDITOR"
EDITOR_NEOVIM="NEOVIM"

# distros

DISTRO_LAZY_VIM="LAZY-VIM"
DISTRO_NV_CHAD="NV-CHAD"
DISTRO_LUNAR_VIM="LUNAR-VIM"
DISTRO_ASTRO_NVIM="ASTRO-NVIM"
DISTRO_HELIX_UPSTREAM="HELIX-UPSTREAM"
DISTRO_HELIX_IS="HELIX-IS" # my fork

# channels

CHANNEL_RELEASE="release" # LUNAR-VIM
CHANNEL_NIGHTLY="nightly" # LUNAR-VIM, ASTRO-NVIM
CHANNEL_NONE="" # HELIX-IS (main branch)

# defaults for:
# - quick editor setup
# - user files edit commands

DEFAULT_EDITOR=$EDITOR_HELIX
DEFAULT_DISTRO=$DISTRO_HELIX_IS
DEFAULT_ACTION=$ACTION_LINK
DEFAULT_CHANNEL=$CHANNEL_NONE

DEFAULT_EDITOR_COMMAND=""
DEFAULT_GIT_COMMAND="lazygit"
DEFAULT_TREE_COMMAND="xplr"

case "$DEFAULT_EDITOR" in
  "$EDITOR_HELIX")
		EDITOR_CACHE_PATH="$PATH_HOME_CACHE/helix"
    EDITOR_CONFIG_PATH="$PATH_HOME_CONFIG/helix"
		EDITOR_SHARE_PATH="$PATH_HOME_LOCAL_SHARE/helix"
		EDITOR_STATE_PATH="$PATH_HOME_LOCAL_STATE/helix"
		MY_EDITOR_CONFIG_PATH="$PATH_REPOS_DOTFILES_CONFIG/helix"
		
    case "$DEFAULT_DISTRO" in
      "$DISTRO_HELIX_UPSTREAM")
		    DEFAULT_EDITOR_COMMAND=hx
      ;;
	    
			"$DISTRO_HELIX_IS")
				DEFAULT_EDITOR_COMMAND="helixis"
			;;	
		esac
  ;;
	
  "$EDITOR_NEOVIM")
  	case "$DEFAULT_DISTRO" in
		  "$DISTRO_LAZY_VIM")
		    DEFAULT_EDITOR_COMMAND=nvim
	    ;;
	    
		  "$DISTRO_NV_CHAD")
		    DEFAULT_EDITOR_COMMAND=nvim
				LUA_CUSTOM_PATH=lua/custom
			;;
			
		  "$DISTRO_LUNAR_VIM")
		    DEFAULT_EDITOR_COMMAND=lvim
	    ;;
	    
		  "$DISTRO_ASTRO_NVIM")
		    DEFAULT_EDITOR_COMMAND=nvim
				LUA_CUSTOM_PATH=lua/user
	    ;;
	    
		esac
		
		EDITOR_CACHE_PATH="$PATH_HOME_CACHE/$DEFAULT_EDITOR_COMMAND"
    EDITOR_CONFIG_PATH="$PATH_HOME_CONFIG/$DEFAULT_EDITOR_COMMAND"
		EDITOR_SHARE_PATH="$PATH_HOME_LOCAL_SHARE/$DEFAULT_EDITOR_COMMAND"
		EDITOR_STATE_PATH="$PATH_HOME_LOCAL_STATE/$DEFAULT_EDITOR_COMMAND"
		MY_EDITOR_CONFIG_PATH="$PATH_REPOS_DOTFILES_CONFIG/$DEFAULT_DISTRO" # config is managed per neovim distro
		
	;;
	
esac

# ==============================
# symlink non-editor app configs
# ==============================

for APP in alacritty starship
do
  APP_CONFIG_PATH=$PATH_HOME_CONFIG/$APP
	MY_APP_CONFIG_PATH=$PATH_REPOS_DOTFILES_CONFIG/$APP/
	
	MSG_CHECKING="\n🕰 Checking $APP config.."
	MSG_SYMLINK_EXISTS="\t🟢 Symlink already exist\n\t\tat: $APP_CONFIG_PATH"
	MSG_SYMLINK_CREATING="\t🕰 Creating symlink to config.."
	MSG_SYMLINK_COMPLETE="\t\t✅ Complete\n\t\t\tSymlink: $APP_CONFIG_PATH\n\t\t\tTargeting: $MY_APP_CONFIG_PATH"
	
	echo -e "$MSG_CHECKING"
	
  if ! [ -L "$APP_CONFIG_PATH" ]
  then
		echo -e "$MSG_SYMLINK_CREATING"
		ln -s "$MY_APP_CONFIG_PATH" "$APP_CONFIG_PATH"
		echo -e "$MSG_SYMLINK_COMPLETE"
	else
		echo -e "$MSG_SYMLINK_EXISTS"
	fi
done

# ============
# editor setup
# ============

ACTION=${1:-"$DEFAULT_ACTION"}
EDITOR=${2:-"$DEFAULT_EDITOR"}
DISTRO=${3:-"$DEFAULT_DISTRO"}
CHANNEL=${4:-"$DEFAULT_CHANNEL"}

CUR_DATETIME=$(date '+%Y-%m-%dT%H:%M:%S')

case "$ACTION" in
	"$ACTION_LINK")
		MSG_SYMLINK_START="\n🕰 Symlinking $EDITOR ($DISTRO) config.."
		MSG_SYMLINK_ERROR="\t🟡 Config not found.\n\t\tChange ACTION from $ACTION to $ACTION_INSTALL"
		
		MSG_SYMLINK_EXISTS="\t🟢 Symlink already exist\n\t\tat: $EDITOR_CONFIG_PATH"
		MSG_FOLDER_EXISTS="\t🟢 Folder detected (verifying setup): $EDITOR_CONFIG_PATH"
		
		MSG_SYMLINK_CREATING="\t🕰 Symlinking $EDITOR ($DISTRO) config.."
		MSG_SYMLINK_COMPLETE="\t\t✅ Complete\n\t\t\tSymlink: $EDITOR_CONFIG_PATH\n\t\t\tTargeting: $MY_EDITOR_CONFIG_PATH"
		
		MSG_BACKUP_CREATING="\t🕰 Backing up $EDITOR ($DISTRO) config.."
		MSG_BACKUP_COMPLETE="\t\t✅ Complete\n\t\t\tBackup: $EDITOR_CONFIG_PATH-$CUR_DATETIME.bak"
		
		echo -e "$MSG_SYMLINK_START"
		
		# symlink nor folder exist
		if ! [ -L "$EDITOR_CONFIG_PATH" ] && ! [ -d "$EDITOR_CONFIG_PATH" ]
		then
	      echo -e "$MSG_SYMLINK_CREATING"
	  		ln -s "$MY_EDITOR_CONFIG_PATH" "$EDITOR_CONFIG_PATH"
		  	echo -e "$MSG_SYMLINK_COMPLETE"
	  fi
		
		if [ -L "$EDITOR_CONFIG_PATH" ]
		then
			echo -e "$MSG_SYMLINK_EXISTS"
		else
		  # symlink doesn't exist
			if [ -d "$EDITOR_CONFIG_PATH" ]
			then
			  # but folder exists
	      echo -e "$MSG_FOLDER_EXISTS"
				
	      if [ "$LUA_CUSTOM_PATH" = "" ]
	      then
	    		# folder should not exist
	      	echo -e "$MSG_BACKUP_CREATING"
	  			mv "$EDITOR_CONFIG_PATH" "$EDITOR_CONFIG_PATH-$CUR_DATETIME.bak"
	  			echo -e "$MSG_BACKUP_COMPLETE"
					
					# symlink to editor config is needed
	      	echo -e "$MSG_SYMLINK_CREATING"
	  			ln -s "$MY_EDITOR_CONFIG_PATH" "$EDITOR_CONFIG_PATH"
		  		echo -e "$MSG_SYMLINK_COMPLETE"
	      else
	        # keep editor config folder (do nothing)
	        # symlink to lua folder is needed
	      	echo -e "$MSG_SYMLINK_CREATING"
	  			ln -s "$MY_EDITOR_CONFIG_PATH/$LUA_CUSTOM_PATH/" "$EDITOR_CONFIG_PATH/$LUA_CUSTOM_PATH"
		  		echo -e "$MSG_SYMLINK_COMPLETE"
	      fi
			else
			  # fatal: the sysmlink was not created
				echo -e "$MSG_SYMLINK_ERROR"
			fi
		fi
	;;
	
	"$ACTION_BACKUP")
    echo -e "\n🕰 Backing up $EDITOR ($DISTRO).."
    for DIR in $EDITOR_CACHE_PATH $EDITOR_CONFIG_PATH $EDITOR_SHARE_PATH $EDITOR_STATE_PATH
    do
      echo -e "\tat: $DIR.."
      if [ -L "$DIR" ]
      then
    	  echo -e "\t\t🕰 Removing existing symlink.."
  	  	rm "$DIR"
  			echo -e "\t\t\t✅ Complete.\n\t\t\t\tSymlink removed at: $DIR"
  		else
        if [ -d "$DIR" ]
        then
  				  echo -e "\t\t🕰 Moving existing config folder.."
  				  mv "$DIR" "$DIR-$CUR_DATETIME.bak"
  				  echo -e "\t\t\t✅ Complete.\n\t\t\t\tMoved to: $DIR-$CUR_DATETIME.bak"
  			else
  				echo -e "\t\t🟡 There's no symlink or folder to backup.\n\t\t\tChange ACTION from $ACTION_BACKUP to $ACTION_INSTALL"
  			fi
  		fi
  	done
	;;
	
	"$ACTION_INSTALL")
		
		MSG_INSTALLING="\n🕰 Installing $EDITOR ($DISTRO).."
		
		MSG_CLONING="\t🕰 Cloning repo.."
		MSG_CLONING_COMPLETE="\t\t✅ Complete.\n\t\t\tCloned at: $EDITOR_CONFIG_PATH"
		
		MSG_SETTING_UP="\t🕰 Setting up.."
	  MSG_SETTING_UP_COMPLETE="\t\t✅ Complete.\n\t\t\tSettings at: $EDITOR_CONFIG_PATH (folder)"
		
		MSG_CALLING="\t🕰 Calling $EDITOR ($DISTRO).."
		MSG_CALLING_COMPLETE="\t\t✅ Complete.\n\t\t\tPlugins Setup"
		
		MSG_SYMLINK_CREATING="\t🕰 Creating symlink..\n\t\tfrom: $MY_EDITOR_CONFIG_PATH/\n\t\tto: $EDITOR_CONFIG_PATH"
		MSG_SYMLINK_EXISTS="\t🟢 Symlink already exist.\n\t\tChange ACTION from $ACTION_INSTALL to $ACTION_BACKUP or $ACTION_LINK"
		MSG_SYMLINK_COMPLETE="\t\t✅ Complete.\n\t\t\tsymlink at: $EDITOR_CONFIG_PATH"
		
		echo -e "$MSG_INSTALLING"
		
		case "$DISTRO" in
		"$DISTRO_HELIX_IS")
			if ! [ -d "$PATH_REPOS_HELIX_IS" ]
      then
				echo -e "$MSG_CLONING"
				mkdir --parents "$PATH_REPOS"
				git clone -q git@github.com:isaldarriaga/helixis.git "$PATH_REPOS_HELIX_IS" --depth 1
				echo -e "$MSG_CLONING_COMPLETE"
				
				echo -e "$MSG_CALLING"
				sleep 2
				$DEFAULT_EDITOR_COMMAND -v
        $DEFAULT_EDITOR_COMMAND --health
				echo -e "$MSG_CALLING_COMPLETE"
			fi
			
      if ! [ -L "$EDITOR_CONFIG_PATH" ]
      then
				echo -e "$MSG_SYMLINK_CREATING"
				ln -s "$MY_EDITOR_CONFIG_PATH/" "$EDITOR_CONFIG_PATH"
				echo -e "$MSG_SYMLINK_COMPLETE"
			else
				echo -e "$MSG_SYMLINK_EXISTS"
			fi
		;;
		
		"$DISTRO_LAZY_VIM")
	    if ! [ -L "$EDITOR_CONFIG_PATH" ]
	    then
				echo -e "$MSG_SYMLINK_CREATING"
				ln -s "$MY_EDITOR_CONFIG_PATH/" "$EDITOR_CONFIG_PATH"
				echo -e "$MSG_SYMLINK_COMPLETE"
				
				echo -e "$MSG_CALLING"
				sleep 2
				$DEFAULT_EDITOR_COMMAND
				echo -e "$MSG_CALLING_COMPLETE"
			else
				echo -e "$MSG_SYMLINK_EXISTS"
			fi
		;;
		
		"$DISTRO_NV_CHAD")
	    if ! [ -d "$EDITOR_CONFIG_PATH" ]
	    then
				echo -e "$MSG_CLONING"
				mkdir --parents "$PATH_REPOS"
				git clone -q https://github.com/NvChad/NvChad "$EDITOR_CONFIG_PATH" --depth 1
				echo -e "$MSG_CLONING_COMPLETE"
				
				echo -e "$MSG_CALLING"
				sleep 2
        $DEFAULT_EDITOR_COMMAND
				echo -e "$MSG_CALLING_COMPLETE"
			fi
			
	    if ! [ -L "$EDITOR_CONFIG_PATH/$LUA_CUSTOM_PATH" ]
	    then
				echo -e "$MSG_SYMLINK_CREATING"
				ln -s "$MY_EDITOR_CONFIG_PATH/$LUA_CUSTOM_PATH/" "$EDITOR_CONFIG_PATH/$LUA_CUSTOM_PATH"
				echo -e "$MSG_SYMLINK_COMPLETE/$LUA_CUSTOM_PATH" # appends lua path to msg
			else
				echo -e "$MSG_SYMLINK_EXISTS"
			fi
		;;
		
	  "$DISTRO_LUNAR_VIM")
      if ! [ -L "$EDITOR_CONFIG_PATH" ]
	    then
        echo -e "$MSG_SETTING_UP"

	      case "$CHANNEL" in
	        "$CHANNEL_RELEASE")
	          LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
	          ;;
	        "$CHANNEL_NIGHTLY")
	          bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
	          ;;
	      esac

	      echo -e "$MSG_SETTING_UP_COMPLETE"
	      $DEFAULT_EDITOR_COMMAND -v
	      $DEFAULT_EDITOR_COMMAND -c checkhealth
			else
				echo -e "$MSG_SYMLINK_EXISTS"
			fi
		;;
		
	  "$DISTRO_ASTRO_NVIM")    
	    if ! [ -d "$EDITOR_CONFIG_PATH" ]
	    then
				echo -e "$MSG_CLONING"
				mkdir --parents "$PATH_REPOS"
				git clone --depth 1 https://github.com/AstroNvim/AstroNvim "$EDITOR_CONFIG_PATH" --depth 1
				echo -e "$MSG_CLONING_COMPLETE"
				
				echo -e "$MSG_CALLING"
	      $DEFAULT_EDITOR_COMMAND --headless +q
				echo -e "$MSG_CALLING_COMPLETE"
				
	      $DEFAULT_EDITOR_COMMAND -v
				
	      $DEFAULT_EDITOR_COMMAND -c checkhealth
			fi
			
	    if ! [ -L "$EDITOR_CONFIG_PATH/$LUA_CUSTOM_PATH" ]
	    then
				echo -e "$MSG_SYMLINK_CREATING"
				ln -s "$MY_EDITOR_CONFIG_PATH/$LUA_CUSTOM_PATH/" "$EDITOR_CONFIG_PATH/$LUA_CUSTOM_PATH"
				echo -e "$MSG_SYMLINK_COMPLETE/$LUA_CUSTOM_PATH" # appends lua path to msg
			else
				echo -e "$MSG_SYMLINK_EXISTS"
			fi
		;;
		esac
	;;
	
esac

# =======
# exports
# =======

# man coloring
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# k3s
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

# force default editor at gui
export EDITOR=$DEFAULT_EDITOR_COMMAND
export VISUAL=$DEFAULT_EDITOR_COMMAND

# locales (fix fonts)
export LC_ALL=C.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_CTYPE_CTYPE=en_US.UTF-8

# nvm bash completion
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# TODO: add commands to export fonts in WSL
# TODO: add commands to install deps in a new shell
# bash-language-server, shellcheck
# biome
# rustup, rust-analyser
# nvm
# tmux
# alacritty
# starship

# =========
# functions
# =========

function savecwd() {
	CWD_TMP=$(pwd)
	echo -e "\n\t💾 cwd saved to: $CWD_TMP"
}

function loadcwd() {
	cd "$CWD_TMP" || return
	echo -e "\n\t✅ cwd restored to: $CWD_TMP"
}

function changedir() {
	echo -e "\n\t📂 changing dir to: $1"
	cd "$1" || return
}

function helixis() {
  if [ -f "$1" ]
  then
    EDIT_FILE="$1"
  else
    EDIT_FILE="."
  fi
  EDIT_PATH=$(dirname "$EDIT_FILE")
  echo "EDIT_FILE: $EDIT_FILE, EDIT_PATH: $EDIT_PATH"

  savecwd
  changedir $PATH_REPOS_HELIX_IS
  cargo run -- $EDIT_FILE -w $EDIT_PATH
  loadcwd
}

# =======
# aliases
# =======

# quick move commands
alias cdapi='changedir "$PATH_REPOS_API"'
alias cdbash='cdhome'
alias cdconfig='changedir "$PATH_HOME_CONFIG"'
alias cddot='changedir "$PATH_REPOS_DOTFILES"'
alias cdhelix='changedir "$PATH_REPOS_HELIX_IS"'
alias cdhome='changedir "$PATH_HOME"'
alias cdrepos='changedir "$PATH_REPOS"'
alias cdshare='changedir "$PATH_HOME_LOCAL_SHARE"'
alias cdweb='changedir "$PATH_REPOS_WEB"'

# quick edit commands
alias eapi="helixis $PATH_REPOS_API"
alias ebash="helixis $PATH_HOME_BASHRC"
alias econfig="helixis $PATH_HOME_CONFIG "
alias edot="helixis $PATH_REPOS_DOTFILES "
alias ehelix="helixis helix-term/src/keymap/default.rs helix-term/src/commands.rs"
alias ehome="helixis $PATH_HOME"
alias erepos="helixis $PATH_REPOS"
alias eshare="helixis $PATH_HOME_LOCAL_SHARE"
alias eweb="helixis $PATH_REPOS_WEB"

# quick lazy git commands
alias gapi="savecwd && cdapi && $DEFAULT_GIT_COMMAND && loadcwd"
alias gbash="savecwd && cddot && $DEFAULT_GIT_COMMAND && loadcwd"
alias gdot="savecwd && cddot && $DEFAULT_GIT_COMMAND && loadcwd"
alias ghelix="savecwd && cdhelix && $DEFAULT_GIT_COMMAND && loadcwd"
alias grepos="savecwd && cdrepos && $DEFAULT_GIT_COMMAND && loadcwd"
alias gweb="savecwd && cdweb && $DEFAULT_GIT_COMMAND && loadcwd"

# quick source commands
alias sbash="source $PATH_HOME_BASHRC" # source .bashrc

# quick editor setup commands
alias ebak="sbash $ACTION_BACKUP $DEFAULT_EDITOR $DEFAULT_DISTRO"
alias einstall="sbash $ACTION_INSTALL $DEFAULT_EDITOR $DEFAULT_DISTRO $DEFAULT_CHANNEL"
alias elink="sbash $ACTION_CONFIG $DEFAULT_EDITOR $DEFAULT_DISTRO"

# quick utility commands
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

# error messages from journalctl
alias jctl="journalctl -p 3 -xb"
alias journalctl="jctl"

# containers
alias mk="minikube"
alias k="sudo k3s kubectl"
alias pm="podman"
alias db="distrobox"

# git
alias lg="lazygit"
alias gui="gitui"

alias hx="$DEFAULT_EDITOR_COMMAND"
alias v="$DEFAULT_EDITOR_COMMAND"
alias vi="$DEFAULT_EDITOR_COMMAND"
alias vim="$DEFAULT_EDITOR_COMMAND"

# other
alias tree="$DEFAULT_TREE_COMMAND"
alias warmup="typeracer"

# ======================
# command-not-found hook
# ======================

if [ -f /etc/arch-release ]; then
	source /usr/share/doc/find-the-command/ftc.bash
fi

# ===================
# Replace ls with exa
# ===================

LS='exa -al --color=always --group-directories-first'         # preferred listing
LA='exa -al --color=always --group-directories-first'         # all files and dirs
LL='exa -l --color=always --group-directories-first --icons'  # long format
LT='exa -aT --color=always --group-directories-first --icons' # tree listing
LDOT="exa -a | egrep '^\.'"                                   # only dot files

# =========
# setup tty
# =========

case $(tty) in
	/dev/tty[0-9]*)
		echo -e "tty detected!"
		
		setfont -d
		showconsolefont
		
		alias ls="$LS"
		alias la="$LA"
		alias ll="$LL"
		alias lt="$LT"
		alias l.="$LDOT"
	;;
	
esac

# =======================
# setup terminal emulator
# =======================

case $(tty) in
  /dev/pts/[0-9]*)
    
    EMULATOR=$(basename "$SHELL")
		echo -e "emulator: $EMULATOR"
		
		if [ "$EMULATOR" = "bash" ]; then
			eval "$(starship init bash)"
		elif [ "$EMULATOR" = "fish" ]; then
			starship init fish | source
		fi
		
		export STARSHIP_CONFIG=~/.config/starship/starship.toml
		
		alias ls="$LS --icons"
		alias la="$LA --icons"
		alias ll="$LL --icons"
		alias lt="$LT --icons"
		alias l.="$LDOT"
	;;
	
esac

# ==================
# blinking underline
# ==================

echo -e -n "\x1b[\x33 q" 

# ============
# cargo envars
# ============

if [ -f "$PATH_HOME_CARGO/env" ]; then
	source "$PATH_HOME_CARGO/env"
fi

# =======
# history
# =======

# append instead of overwrite in multi-session
shopt -s histappend

# reload history file
# PROMPT_COMMAND="$PROMPT_COMMAND;history -a; history -n"

