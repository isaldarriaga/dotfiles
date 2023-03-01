PWD=$(pwd) && \

symlink_folder() {
 echo && \
SYM=~/.config/alacritty/alacritty && \
SRC=~/repos/.dotfiles/home/.config/alacritty && \
MSG="Symlinking $SYM ..." && echo && echo "$MSG" && \
rm $SYM && mkdir --parents  
}
