# Instructions
- Copy the contents of `/etc/nixos/configuration.nix` into the respective file.
- RUN: `sudo nixos-rebuild switch`
- Having git installed clone the repo

# KDE shortcuts
- RUN: `DIR=~/.config && \
LINK=kglobalshortcutsrc && \
sudo mv $DIR/$LINK $DIR/$LINK.bak && \
cd $DIR && \
sudo ln -s ~/repos/.dotfiles$DIR/$LINK $LINK && \
ls -l $DIR/$LINK`
- re-login

# nixos (https://releases.nixos.org/?prefix=nixos/unstable/)
- RUN: `DIR=/etc/nixos && \
LINK=configuration.nix && \
sudo mv $DIR/$LINK $DIR/$LINK.bak && \
cd $DIR && \
sudo ln -s ~/repos/.dotfiles$DIR/$LINK $LINK && \
ls -l $DIR/$LINK`

# Helix
- RUN: `DIR=~/.config && LINK=helix && \
sudo mv $DIR/$LINK $DIR/$LINK.bak && \
cd $DIR && \
sudo ln -s ~/repos/.dotfiles$DIR/$LINK $LINK && \
ls -l $DIR/$LINK`

# Theme
- Manually change KDE theme to "Sweet KDE"
