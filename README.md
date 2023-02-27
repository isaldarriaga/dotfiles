# Instructions
- Copy the contents of `/etc/nixos/configuration.nix` into the respective file.
```sudo nixos-rebuild switch```
- Clone the repo (git is now available)

# KDE shortcuts
```DIR=~/.config && \
LINK=kglobalshortcutsrc && \
sudo mv $DIR/$LINK $DIR/$LINK.bak && \
cd $DIR && \
sudo ln -s ~/repos/.dotfiles$DIR/$LINK $LINK && \
ls -l $DIR/$LINK```

- re-login

# nixos (https://releases.nixos.org/?prefix=nixos/unstable/)
```DIR=/etc/nixos && \
LINK=configuration.nix && \
sudo mv $DIR/$LINK $DIR/$LINK.bak && \
cd $DIR && \
sudo ln -s ~/repos/.dotfiles$DIR/$LINK $LINK && \
ls -l $DIR/$LINK```

# Helix
```DIR=~/.config && LINK=helix && \
sudo mv $DIR/$LINK $DIR/$LINK.bak && \
cd $DIR && \
sudo ln -s ~/repos/.dotfiles$DIR/$LINK $LINK && \
ls -l $DIR/$LINK```

# Theme
- Manually change KDE theme to "Sweet KDE"
