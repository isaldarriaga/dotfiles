# nixos
DIR=/etc/nixos    && LINK=configuration.nix && sudo mv $DIR/$LINK $DIR/$LINK.bak && cd $DIR && sudo ln -s ~/repos/.dotfiles$DIR/$LINK $LINK && ls -l $DIR/$LINK

# Helix (unstable)
sudo nix-channel --list
sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
sudo nix-channel --list
sudo nix-channel --update
sudo nix search nixpkgs helix
sudo nix shell helix

DIR=/home/.config && LINK=helix             && sudo mv $DIR/$LINK $DIR/$LINK.bak && cd $DIR && sudo ln -s ~/repos/.dotfiles$DIR/$LINK $LINK && ls -l $DIR/$LINK

# Pacman (does not work)
# DIR=/etc          && LINK=pacman.conf       && sudo mv $DIR/$LINK $DIR/$LINK.bak && cd $DIR && sudo ln -s ~/repos/.dotfiles$DIR/$LINK $LINK && ls -l $DIR/$LINK
# DIR=/etc          && LINK=pacman.d          && sudo mv $DIR/$LINK $DIR/$LINK.bak && cd $DIR && sudo ln -s ~/repos/.dotfiles$DIR/$LINK $LINK && ls -l $DIR/$LINK
# DIR=/var/log      && LINK=pacman.log        && sudo mv $DIR/$LINK $DIR/$LINK.bak && cd $DIR && sudo ln -s ~/repos/.dotfiles$DIR/$LINK $LINK && ls -l $DIR/$LINK
# DIR=/var/log      && LINK=pacman.log        && sudo mv $DIR/$LINK $DIR/$LINK.bak && cd $DIR && sudo ln -s ~/repos/.dotfiles$DIR/$LINK $LINK && ls -l $DIR/$LINK