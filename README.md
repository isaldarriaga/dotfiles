# Instructions
- Copy the contents of `/etc/nixos/configuration.nix` into the respective file.

```sudo nixos-rebuild switch```

- Clone the repo (git is now available)

# KDE

```
DIR=.config && \
LINK=kglobalshortcutsrc && \
sudo mv "$HOME/$DIR/$LINK" "$HOME/$DIR/$LINK.bak" ; \
cd "$HOME/$DIR" && \
sudo ln -s "$HOME/repos/.dotfiles/home/$DIR/$LINK" $LINK && \
ls -l "$HOME/$DIR/$LINK"
```

```
DIR=.config && \
LINK=kdeglobals && \
sudo mv "$HOME/$DIR/$LINK" "$HOME/$DIR/$LINK.bak" ; \
cd "$HOME/$DIR" && \
sudo ln -s "$HOME/repos/.dotfiles/home/$DIR/$LINK" $LINK && \
ls -l "$HOME/$DIR/$LINK"
```

```
DIR=.config && \
LINK=kwinrc && \
sudo mv "$HOME/$DIR/$LINK" "$HOME/$DIR/$LINK.bak" ; \
cd "$HOME/$DIR" && \
sudo ln -s "$HOME/repos/.dotfiles/home/$DIR/$LINK" $LINK && \
ls -l "$HOME/$DIR/$LINK"
```

- re-login

# nixos (https://releases.nixos.org/?prefix=nixos/unstable/)

```
DIR=/etc/nixos && \
LINK=configuration.nix && \
sudo mv $DIR/$LINK $DIR/$LINK.bak && \
cd $DIR && \
sudo ln -s ~/repos/.dotfiles$DIR/$LINK $LINK && \
ls -l $DIR/$LINK
```

# Helix

```
DIR=.config && \
LINK=helix && \
sudo mv "$HOME/$DIR/$LINK" "$HOME/$DIR/$LINK.bak" ; \
cd "$HOME/$DIR" && \
sudo ln -s "$HOME/repos/.dotfiles/home/$DIR/$LINK" $LINK && \
ls -l "$HOME/$DIR/$LINK"
```

# Theme
- Manually change KDE theme to "Sweet KDE"
