echo && \
FILE=~/repos/.dotfiles/etc/nixos/configuration.nix && \
SETTING="services.xserver.videoDrivers" && \
SRC="$SETTING = [ \"nvidia\" ];" && \
DST="$SETTING = [ \"amdgpu\" ];" && \
echo "SRC: $SRC" && \
echo "DST: $DST" && \
echo && echo "Before: $(cat $FILE | grep "$SETTING")" && \
echo && echo "switching to amdgpu..." && \
REGEX="s/$SRC/$DST/g" && \
echo && echo "REGEX: $REGEX" && \
sed -i "\'$REGEX\'" $FILE && \
echo && echo "After:  $(cat $FILE | grep "$SETTING")"
