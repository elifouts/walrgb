<p align="center">
  <a href="https://git.io/typing-svg">
    <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&duration=3000&pause=1000&color=14CB0B&center=true&multiline=true&width=435&lines=walrgb%24" alt="Typing SVG" />
  </a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/pywal-colors-14cb0b?style=for-the-badge&labelColor=0a0a0a">
  <img src="https://img.shields.io/badge/OpenRGB-backend-0ce96b?style=for-the-badge&labelColor=0a0a0a">
  <img src="https://img.shields.io/badge/applies%20in-50ms-52ff9c?style=for-the-badge&labelColor=0a0a0a">
</p>

Syncs your motherboard, RAM, AIO pump, fans, GPU, keyboard and anything else [OpenRGB](https://openrgb.org) supports to your **Pywal** colors. No pywal? Pick any color, default is blue.

Run `walrgb apply` after pywal, from a terminal, a script or a keybind.

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
  walrgb instant on
  ```

  RAM sits on SMBus, so add yourself to the `i2c` group and log back in: `sudo usermod -aG i2c $USER`
</details>

## Apply

walrgb installs to `/usr/local/bin`, so `walrgb apply` works from any script or keybind. It applies in the background and returns at once, so your script keeps going. Errors go to `~/.cache/walrgb/apply.log`.

```sh
walrgb apply                              # push the current colors now
wal -i ~/pics/wall.png && walrgb apply    # in a script or keybind
walrgb apply --fg                         # wait until it's done
```

Config commands like `walrgb color` apply right away too, and the tui applies when you quit.

## Instant

By default `walrgb-openrgb.service` keeps OpenRGB's server running, so colors change in about 50ms. It uses around 14MB of RAM and a sliver of CPU while idle.

```sh
walrgb instant off   # nothing stays running, each change takes ~1s while OpenRGB scans
walrgb instant on    # back to instant
walrgb instant       # which one you're on
```

With instant off, your lights keep their color after OpenRGB exits, because walrgb only uses each device's static mode and its own built-in rainbow.

> [!NOTE]
> OpenRGB logs `recv_select failed receiving magic` every time walrgb disconnects. That's normal.

## Use

```sh
walrgb                      # tui with a preview of every device
walrgb color accent         # default. also wal0-15 or #ff8800
walrgb mode rainbow         # static, or each device's own built-in rainbow
walrgb mode rainbow ram     # per device, by name or type
walrgb off keyboard         # hand it back, it gets its factory effect
```

> [!NOTE]
> walrgb sets your lights once and exits, it never sits in a loop. Colors are gamma corrected for LEDs so they match your screen.

<details>
  <summary><b>Missing a device?</b></summary>

  - **Fans / pumps** on ARGB headers start at 0 LEDs. walrgb sizes them to 60. For the exact count: `walrgb zone JRAINBOW1 24`
  - **RAM** missing: check `groups` for `i2c`. Some AMD boards also need the `acpi_enforce_resources=lax` kernel parameter.
  - If it's not in `openrgb --list-devices`, walrgb can't see it either. See the [OpenRGB device list](https://openrgb.org/devices.html).
</details>
