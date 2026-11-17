#!/bin/sh
# ./install.sh      install for this user
# ./install.sh -u   uninstall. gives your lights back first
set -e
cd "$(dirname "$0")"
LOCAL="PREFIX=$HOME/.local UNITDIR=$HOME/.config/systemd/user"
hex=$(sed -n 2p "$HOME/.cache/wal/colors" 2>/dev/null | tr -d '#')
[ ${#hex} -eq 6 ] || hex=14cb0b
c=$(printf '\033[38;2;%d;%d;%dm' "0x$(echo $hex | cut -c1-2)" "0x$(echo $hex | cut -c3-4)" "0x$(echo $hex | cut -c5-6)")
say() { printf '%s::\033[0m %s\n' "$c" "$*"; }

if [ "$1" = -u ]; then
    say "giving your devices their factory effects back"
    "$HOME/.local/bin/walrgb" reset 2>/dev/null || true
    make -s $LOCAL disable uninstall
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
make -s $LOCAL install enable
say "installed. run walrgb to open the tui"
[ -z "$relog" ] || say "log out and back in once so the i2c group kicks in"
