#!/bin/sh
# ./install.sh      install
# ./install.sh -u   uninstall. gives your lights back first
set -e
cd "$(dirname "$0")"
UNITS="UNITDIR=$HOME/.config/systemd/user"
hex=$(sed -n 2p "$HOME/.cache/wal/colors" 2>/dev/null | tr -d '#')
[ ${#hex} -eq 6 ] || hex=14cb0b
c=$(printf '\033[38;2;%d;%d;%dm' "0x$(echo $hex | cut -c1-2)" "0x$(echo $hex | cut -c3-4)" "0x$(echo $hex | cut -c5-6)")
say() { printf '%s::\033[0m %s\n' "$c" "$*"; }
# as root it'd set up root's lights and root's systemd. it sudos the bits that need it
[ "$(id -u)" -ne 0 ] || { say "run it without sudo, it asks for your password when it needs it"; exit 1; }

make -s $UNITS disable >/dev/null 2>&1 || true
# older versions lived in ~/.local/bin and watched pywal with a path unit
systemctl --user disable --now walrgb.path walrgb.service >/dev/null 2>&1 || true
[ ! -e "$HOME/.local/bin/walrgb" ] || moved=1
rm -f "$HOME/.local/bin/walrgb" "$HOME/.config/systemd/user/walrgb.path" "$HOME/.config/systemd/user/walrgb.service"

if [ "$1" = -u ]; then
    say "giving your devices their factory effects back"
    walrgb reset 2>/dev/null || true
    make -s $UNITS uninstall-units
    sudo make -s uninstall-bin
    systemctl --user daemon-reload
    say "removed. your config is still in ~/.config/walrgb"
    exit 0
fi

command -v openrgb >/dev/null || { say "installing openrgb"; sudo pacman -S --needed openrgb; }
if ! id -nG | grep -qw i2c; then
    say "adding you to the i2c group so openrgb can reach your ram"
    sudo usermod -aG i2c "$USER"
    relog=1
fi
if [ ! -e /etc/modules-load.d/i2c-dev.conf ] && ! lsmod | grep -q '^i2c_dev'; then
    say "loading i2c-dev on boot"
    echo i2c-dev | sudo tee /etc/modules-load.d/i2c-dev.conf >/dev/null
    sudo modprobe i2c-dev
fi
# /usr/local/bin so scripts and keybinds find it, hyprland's PATH has no ~/.local/bin
sudo make -s install-bin
make -s $UNITS install-units
make -s $UNITS enable
say "installed. run walrgb apply after wal (or in your theme script), walrgb for the tui"
say "walrgb instant off if you'd rather nothing stays running (applies take ~1s then)"
# bash remembers the old ~/.local/bin path and says "no such file" until it forgets it
[ -z "$moved" ] || say "walrgb moved to /usr/local/bin, run hash -r or open a new terminal"
[ -z "$relog" ] || say "log out and back in once so the i2c group kicks in"
