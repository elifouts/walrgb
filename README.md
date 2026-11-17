<p align="center">
  <a href="https://git.io/typing-svg">
    <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&duration=3000&pause=1000&color=14CB0B&center=true&multiline=true&width=435&lines=walrgb%24" alt="Typing SVG" />
  </a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/pywal-colors-14cb0b?style=for-the-badge&labelColor=0a0a0a">
  <img src="https://img.shields.io/badge/OpenRGB-backend-0ce96b?style=for-the-badge&labelColor=0a0a0a">
  <img src="https://img.shields.io/badge/idle-0%25%20cpu-52ff9c?style=for-the-badge&labelColor=0a0a0a">
</p>

Syncs your motherboard, RAM, AIO pump, fans, GPU, keyboard and anything else [OpenRGB](https://openrgb.org) supports to your **Pywal** colors. No pywal? Pick any color, default is blue.

Nothing runs in the background. systemd watches `~/.cache/wal/colors` and walrgb pushes the new colors once when they change.

# Install

```sh
git clone https://github.com/elifouts/walrgb.git && cd walrgb && ./install.sh
```

```sh
./install.sh -u     # uninstall, devices get their factory effect back
```

> [!TIP]
> Run `walrgb detect` to see every device, its LEDs, and how each mode runs on it.

<details>
  <summary><b>AUR / manual</b></summary>

  ```sh
  yay -S walrgb
  systemctl --user enable --now walrgb.path
  ```

  RAM sits on SMBus, so add yourself to the `i2c` group and log back in: `sudo usermod -aG i2c $USER`
</details>

## Use

```sh
walrgb                      # tui with a live preview of every device
walrgb mode wave            # static palette breathing flashing cycle wave rainbow
walrgb mode rainbow ram     # per device, by name or type
walrgb color accent         # default. also wal0-15 or #ff8800
walrgb cycle 10             # alternate through wal1-6 every 10s
walrgb off keyboard         # hand it back, it gets its factory effect
```

> [!NOTE]
> Every mode works on every device. If the hardware has the effect, the hardware runs it. If not, walrgb animates it (per key on keyboards) and only stays running while it does.

<details>
  <summary><b>Missing a device?</b></summary>

  - **Fans / pumps** on ARGB headers start at 0 LEDs. walrgb sizes them to 60. For the exact count: `walrgb zone JRAINBOW1 24`
  - **RAM** missing: check `groups` for `i2c`. Some AMD boards also need the `acpi_enforce_resources=lax` kernel parameter.
  - If it's not in `openrgb --list-devices`, walrgb can't see it either. See the [OpenRGB device list](https://openrgb.org/devices.html).
</details>
