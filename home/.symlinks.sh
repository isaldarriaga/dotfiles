SYMLINK=$1
TARGET=$2
PWD=$(pwd)
BAK="bak-$(date +%Y-%m-%d)"

symlink_folder() {
  if [ ! -d "$SYMLINK" ]; then
    MSG="Creating parent folder for $SYMLINK ..." && echo && echo "$MSG" && \
    mkdir --parents $SYMLINK 
  fi
  
  if [ -f "$SYMLINK" ]; then
    MSG="Backing up $SYMLINK ..." && echo && echo "$MSG" && \
    mv $SYMLINK "$SYMLINKINK.$BAK"
  fi

  MSG="Symlinking folder $SYMLINK ..." && echo && echo "$MSG" && \
  ln -s $TARGET $SYMLINK & \
  MSG="Symlink created: " && echo && echo "$MSG" && \
  ls -al $SYMLINK
}
