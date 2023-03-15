echo && \
FILE=~/repos/.dotfiles/etc/nixos/configuration.nix && \
SETTING="services.xserver.videoDrivers" && \
SRC="$SETTING = [ \"amdgpu\" ];" && \
DST="$SETTING = [ \"nvidia\" ];" && \
echo "SRC: $SRC" && \
echo "DST: $DST" && \
echo && echo "Before: $(cat $FILE | grep "$SETTING")" && \
echo && echo "switching to nvidia..." && \
sed -i "s/$SRC/$DST/g" $FILE && \
echo && echo "After:  $(cat $FILE | grep "$SETTING")"
