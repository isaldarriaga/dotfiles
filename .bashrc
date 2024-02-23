# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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
    
    EMULATOR=$(basename $SHELL)
		echo -e "$EMULATOR detected!"
		
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
export EDITOR=$DEFAULT_COMMAND
export VISUAL=$DEFAULT_COMMAND

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
# TODO: add commands to ensure tools are installed in a new shell, including LSP

# ==========================
# paths used in this session
# ==========================

# system paths
HOME_PATH="/home/$USER"
BASHRC_PATH="$HOME_PATH/.bashrc"
CONFIG_PATH="$HOME_PATH/.config"
LOCAL_SHARE_PATH="$HOME_PATH/.local/share"

# user paths
REPOS_PATH="$HOME_PATH/repos"
DOTFILES_PATH="$REPOS_PATH/dotfiles"
MY_CONFIG_PATH="$DOTFILES_PATH/config"
HELIX_IS_PATH="$REPOS_PATH/rust/helixis"

# ==============
# setup defaults
# ==============

# actions
BACKUP_ACTION="BACKUP"
INSTALL_ACTION="INSTALL"
SYMLINK_ACTION="SYMLINK"

# editors
HELIX_EDITOR="HELIX-EDITOR"
NEOVIM_EDITOR="NEOVIM"

# distros
LAZY_VIM="LAZY-VIM"
NV_CHAD="NV-CHAD"
LUNAR_VIM="LUNAR-VIM"
ASTRO_NVIM="ASTRO-NVIM"
HELIX_UPSTREAM="HELIX-UPSTREAM"
HELIX_IS="HELIX-IS" # my fork

# channels
RELEASE_CHANNEL="release" # LUNAR-VIM
NIGHTLY_CHANNEL="nightly" # LUNAR-VIM, ASTRO-NVIM
STABLE_CHANNEL="stable" # ASTRO-NVIM
NO_CHANNEL="" # HELIX-IS (main branch)

DEFAULT_EDITOR=$HELIX_EDITOR
DEFAULT_DISTRO=$HELIX_IS
DEFAULT_ACTION=$SYMLINK_ACTION
DEFAULT_CHANNEL=$NO_CHANNEL

PWD=$(pwd)

case "$DEFAULT_EDITOR" in
  "$HELIX_EDITOR")
    case "$DEFAULT_DISTRO" in
    	"$HELIX_UPSTREAM")
		    DEFAULT_COMMAND=hx
	    ;;
			"$HELIX_IS")
				DEFAULT_COMMAND="cd $HELIX_IS_PATH && cargo run"
			;;
		esac
    EDITOR_CONFIG_PATH="$CONFIG_PATH/helix"
		EDITOR_SHARE_PATH="$HOME_SHARE_PATH/helix"
		EDITOR_STATE_PATH="$HOME_CONFIG_PATH/.local/state/helix"
		EDITOR_CACHE_PATH="$HOME_CONFIG_PATH/.cache/helix"
		MY_EDITOR_CONFIG_PATH="$MY_CONFIG_PATH/helix"
  ;;
  "$NEOVIM_EDITOR")
  	case "$DEFAULT_DISTRO" in
		  "$LAZY_VIM")
		    DEFAULT_COMMAND=nvim
	    ;;
		  "$NV_CHAD")
		    DEFAULT_COMMAND=nvim
				LUA_CUSTOM_PATH=lua/custom
			;;
		  "$LUNAR_VIM")
		    DEFAULT_COMMAND=lvim
	    ;;
		  "$ASTRO_NVIM")
		    DEFAULT_COMMAND=nvim
				LUA_CUSTOM_PATH=lua/user
	    ;;
		esac
    EDITOR_CONFIG_PATH="$CONFIG_PATH/$DEFAULT_COMMAND"
		EDITOR_SHARE_PATH="$HOME_SHARE_PATH/$DEFAULT_COMMAND"
		EDITOR_STATE_PATH="$HOME_CONFIG_PATH/.local/state/$DEFAULT_COMMAND"
		EDITOR_CACHE_PATH="$HOME_CONFIG_PATH/.cache/$DEFAULT_COMMAND"
		MY_EDITOR_CONFIG_PATH="$MY_CONFIG_PATH/$DEFAULT_DISTRO" # config is saved per neovim distro
	;;
esac


# ALIASES

# quick pwd
alias pwd_save="export PWD=$(pwd)"
alias pwd_restore="cd $PWD"

# quick system moves
alias cdhome="cd $HOME_PATH"
alias cdconfig="cd $CONFIG_PATH"
alias cdshare="cd $LOCAL_SHARE_PATH"

# quick user moves
alias cdrepos="cd $REPOS_PATH"
alias cddot="cd $DOTFILES_PATH"
alias cdhelixis="cd $HELIX_IS_PATH"

# quick folder edits
alias erepos=$(cdrepos && echo "$DEFAULT_COMMAND .")
alias ehelix=$(cdhelix && echo "$DEFAULT_COMMAND .")
alias edot=$(cddot && echo "$DEFAULT_COMMAND .")
alias eshare=$(cdshare && echo "$DEFAULT_COMMAND .")

# quick file edits
alias ebash=$(echo "$DEFAULT_COMMAND $BASHRC_PATH")

# quick source
alias sbash="source $BASHRC_PATH" # source .bashrc

# quick editor setup
alias ebak="sbash $BACKUP_ACTION $DEFAULT_EDITOR $DEFAULT_DISTRO"
alias einstall="sbash $INSTALL_ACTION $DEFAULT_EDITOR $DEFAULT_DISTRO $DEFAULT_CHANNEL"
alias esymlink="sbash $SYMLINK_ACTION $DEFAULT_EDITOR $DEFAULT_DISTRO"

# utilities
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
alias gu="gitui"

# force default editor at cli
alias v=$DEFAULT_COMMAND
alias vi=$DEFAULT_COMMAND
alias vim=$DEFAULT_COMMAND
alias nano=$DEFAULT_COMMAND
alias hx=$DEFAULT_COMMAND

# other
alias tree="xplr"
alias warmup="typeracer"

# Advanced command-not-found hook
if [ -f /etc/arch-release ]; then
	source /usr/share/doc/find-the-command/ftc.bash
fi

# ==============================
# symlink non-editor app configs
# ==============================

for APP in alacritty starship
do
  APP_CONFIG_PATH=$HOME_CONFIG_PATH/$APP
	MY_APP_CONFIG_PATH=$MY_CONFIG_PATH/$APP/

	MSG_CHECKING="\n🕰 Checking $APP config.."
	MSG_SYMLINK_EXISTS="\t🟢 Symlink already exist\n\t\tat: $APP_CONFIG_PATH"
	MSG_SYMLINK_CREATING="\t🕰 Creating symlink to config.."
	MSG_SYMLINK_COMPLETE="\t\t✅ Complete\n\t\t\tSymlink: $APP_CONFIG_PATH\n\t\t\tTargeting: $MY_APP_CONFIG_PATH"

	echo -e $MSG_CHECKING

  if ! [ -L $APP_CONFIG_PATH ]
  then
		echo -e $MSG_SYMLINK_CREATING
		ln -s $MY_APP_CONFIG_PATH $APP_CONFIG_PATH
		echo -e $MSG_SYMLINK_COMPLETE
	else
		echo -e $MSG_SYMLINK_EXISTS
	fi
done

# ============
# editor setup
# ============

ACTION=${1:-"$DEFAULT_ACTION"}
EDITOR=${2:-"$DEFAULT_EDITOR"}
DISTRO=${3:-"$DEFAULT_DISTO"}
CHANNEL=${4:-"$DEFAULT_CHANNEL"}

COMMAND=$DEFAULT_COMMAND

CUR_DATETIME=$(date '+%Y-%m-%dT%H:%M:%S')

case "$ACTION" in
	"$SYMLINK_ACTION")
		MSG_SYMLINK_START="\n🕰 Symlinking $EDITOR ($DISTRO) config.."
		MSG_SYMLINK_ERROR="\t🟡 Config not found.\n\t\tChange ACTION from $ACTION to 'install'"
	
		MSG_SYMLINK_EXISTS="\t🟢 Symlink already exist\n\t\tat: $EDITOR_CONFIG_PATH"
		MSG_FOLDER_EXISTS="\t🟢 Folder detected (verifying setup): $EDITOR_CONFIG_PATH"
		
		MSG_SYMLINK_CREATING="\t🕰 Symlinking $EDITOR ($DISTRO) config.."
		MSG_SYMLINK_COMPLETE="\t\t✅ Complete\n\t\t\tSymlink: $EDITOR_CONFIG_PATH\n\t\t\tTargeting: $MY_EDITOR_CONFIG_PATH"
		
		MSG_BACKUP_CREATING="\t🕰 Backing up $EDITOR ($DISTRO) config.."
		MSG_BACKUP_COMPLETE="\t\t✅ Complete\n\t\t\tBackup: $EDITOR_CONFIG_PATH-$CUR_DATETIME.bak"

		echo -e $MSG_SYMLINK_START

		# symlink nor folder exist
		if ! [ -L $EDITOR_CONFIG_PATH ] && ! [ -d $EDITOR_CONFIG_PATH ]
		then
	      echo -e $MSG_SYMLINK_CREATING
	  		ln -s $MY_EDITOR_CONFIG_PATH $EDITOR_CONFIG_PATH
		  	echo -e $MSG_SYMLINK_COMPLETE
	  fi

		if [ -L $EDITOR_CONFIG_PATH ]
		then
			echo -e $MSG_SYMLINK_EXISTS
		else
			if [ -d $EDITOR_CONFIG_PATH ]
			then
	      echo -e $MSG_FOLDER_EXISTS

	      if [ $LUA_CUSTOM_PATH == "" ]
	      then
	    		# folder should not exist
	      	echo -e $MSG_BACKUP_CREATING
	  			mv $EDITOR_CONFIG_PATH{,-$CUR_DATETIME.bak}
	  			echo -e $MSG_BACKUP_COMPLETE

					# symlink to editor config is needed
	      	echo -e $MSG_SYMLINK_CREATING
	  			ln -s $MY_EDITOR_CONFIG_PATH $EDITOR_CONFIG_PATH
		  		echo -e $MSG_SYMLINK_COMPLETE
	      else
	        # keep editor config folder (do nothing)
	        # symlink to lua folder is needed
	      	echo -e $MSG_SYMLINK_CREATING
	  			ln -s $MY_EDITOR_CONFIG_PATH/$LUA_CUSTOM_PATH/ $EDITOR_CONFIG_PATH/$LUA_CUSTOM_PATH
		  		echo -e $MSG_SYMLINK_COMPLETE
	      fi
			else
				echo -e $MSG_SYMLINK_ERROR
			fi
		fi
		;;

	"$BACKUP_ACTION")
	    echo -e "\n🕰 Backing up $EDITOR ($DISTRO).."
	    for DIR in $EDITOR_CONFIG_PATH $EDITOR_SHARE_PATH $EDITOR_STATE_PATH $EDITOR_CACHE_PATH
	    do
	      echo -e "\tat: $DIR.."
	      if [ -L $DIR ]
	      then
	    	  echo -e "\t\t🕰 Removing existing symlink.."
	  	  	rm $DIR
	  			echo -e "\t\t\t✅ Complete.\n\t\t\t\tSymlink removed at: $DIR"
	  		else
	        if [ -d $DIR ]
	        then
	  				  echo -e "\t\t🕰 Moving existing config folder.."
	  				  mv $DIR{,-$CUR_DATETIME.bak}
	  				  echo -e "\t\t\t✅ Complete.\n\t\t\t\tMoved to: $DIR-$CUR_DATETIME.bak"
	  			else
	  				echo -e "\t\t🟡 There's no symlink or folder to backup.\n\t\t\tChange ACTION from $BACKUP_ACTION to $INSTALL_ACTION"
	  			fi
	  		fi
	  	done
		;;

	"$INSTALL_ACTION")

		MSG_INSTALLING="\n🕰 Installing $EDITOR ($DISTRO).."

		MSG_CLONING="\t🕰 Cloning repo.."
		MSG_CLONING_COMPLETE="\t\t✅ Complete.\n\t\t\tCloned at: $EDITOR_CONFIG_PATH"

		MSG_SETTING_UP="\t🕰 Setting up.."
	  MSG_SETTING_UP_COMPLETE="\t\t✅ Complete.\n\t\t\tSettings at: $EDITOR_CONFIG_PATH (folder)"

		MSG_CALLING="\t🕰 Calling $EDITOR ($DISTRO).."
		MSG_CALLING_COMPLETE="\t\t✅ Complete.\n\t\t\tPlugins Setup"

		MSG_SYMLINK_CREATING="\t🕰 Creating symlink..\n\t\tfrom: $MY_EDITOR_CONFIG_PATH/$DISTRO/\n\t\tto: $EDITOR_CONFIG_PATH"
		MSG_SYMLINK_EXISTS="\t🟢 Symlink already exist.\n\t\tChange ACTION from $INSTALL_ACTION to $BACKUP_ACTION or $SYMLINK_ACTION"
		MSG_SYMLINK_COMPLETE="\t\t✅ Complete.\n\t\t\tsymlink at: $EDITOR_CONFIG_PATH"

		echo -e $MSG_INSTALLING

		case "$DISTRO" in
		"$LAZY_VIM")
	    if ! [ -L $EDITOR_CONFIG_PATH ]
	    then
				echo -e $MSG_SYMLINK_CREATING
				ln -s $MY_EDITOR_CONFIG_PATH/$DISTRO/ $EDITOR_CONFIG_PATH
				echo -e $MSG_SYMLINK_COMPLETE

				echo -e $MSG_CALLING
				sleep 2
				$(echo $COMMAND)
				echo -e $MSG_CALLING_COMPLETE
			else
				echo -e $MSG_SYMLINK_EXISTS
			fi
			;;

		"$NV_CHAD")
	    if ! [ -d $EDITOR_CONFIG_PATH ]
	    then
				echo -e $MSG_CLONING
				git clone -q https://github.com/NvChad/NvChad $APP_CONFIG_PATH --depth 1
				echo -e $MSG_CLONING_COMPLETE

				echo -e $MSG_CALLING
				sleep 2
	      $(echo $COMMAND)
				echo -e $MSG_CALLING_COMPLETE
			fi

	    if ! [ -L $EDITOR_CONFIG_PATH/$LUA_CUSTOM_PATH ]
	    then
				echo -e $MSG_SYMLINK_CREATING
				ln -s $MY_EDITOR_CONFIG_PATH/$LUA_CUSTOM_PATH/ $EDITOR_CONFIG_PATH/$LUA_CUSTOM_PATH
				echo -e $MSG_SYMLINK_COMPLETE/$LUA_CUSTOM_PATH # appends lua path to msg
			else
				echo -e $MSG_SYMLINK_EXISTS
			fi
			;;

	  "$LUNAR_VIM")
	    if ! [ -L $EDITOR_CONFIG_PATH ]
	    then
				echo -e $MSG_SETTING_UP
	      case "$CHANNEL" in
	        "$RELEASE_CHANNEL")
	          LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
	          ;;
	        "$NIGHTLY_CHANNEL")
	          bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
	          ;;
	      esac
	      echo -e $MSG_SETTING_UP_COMPLETE

	      $(echo "$COMMAND -v")

	      $(echo "$COMMAND -c checkhealth")
			else
				echo -e $MSG_SYMLINK_EXISTS
			fi
			;;

	  "$ASTRO_NVIM")    
	    if ! [ -d $EDITOR_CONFIG_PATH ]
	    then
				echo -e $MSG_CLONING
				git clone --depth 1 https://github.com/AstroNvim/AstroNvim $APP_CONFIG_PATH --depth 1
				echo -e $MSG_CLONING_COMPLETE

				echo -e $MSG_CALLING
	      $(echo "$COMMAND --headless +q")
				echo -e $MSG_CALLING_COMPLETE

	      $(echo "$COMMAND -v")

	      $(echo "$COMMAND -c checkhealth")
			fi

	    if ! [ -L $EDITOR_CONFIG_PATH/$LUA_CUSTOM_PATH ]
	    then
				echo -e $MSG_SYMLINK_CREATING
				ln -s $MY_EDITOR_CONFIG_PATH/$LUA_CUSTOM_PATH/ $EDITOR_CONFIG_PATH/$LUA_CUSTOM_PATH
				echo -e $MSG_SYMLINK_COMPLETE/$LUA_CUSTOM_PATH # appends lua path to msg
			else
				echo -e $MSG_SYMLINK_EXISTS
			fi
		  ;;
		esac
	;;

esac
