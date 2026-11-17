<p align="center">
  <a href="https://git.io/typing-svg">
    <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&duration=3000&pause=1000&color=ffffff&center=true&multiline=true&width=435&lines=walrgb%24" alt="walrgb" />
  </a>
</p>

Sync your RGB devices with **Pywal** colors using [OpenRGB](https://openrgb.org). Supports motherboards, RAM, GPUs, fans, keyboards, and more. No Pywal? Use any color.

<img width="1028" height="485" alt="image" src="https://github.com/user-attachments/assets/e7ffbd6d-33c1-4539-81f2-e9a4952e27d0" />

### Install

```sh
git clone https://github.com/elifouts/walrgb.git
cd walrgb
./install.sh
```

Or install from the AUR:

```sh
yay -S walrgb
```

### Usage

Run `walrgb apply` after `wal` or add it to your theme script to sync RGB hardware with Pywal.

```sh
walrgb                           # Open TUI
walrgb detect                    # List devices and supported modes
walrgb instant [on|off]          # Enable fast background control (default: on)
walrgb apply [--fg]              # Apply current colors (--fg for foreground)
walrgb on|off|toggle [DEV]       # Control lighting or walrgb ownership
walrgb mode static|rainbow [DEV] # Set lighting mode
walrgb color SPEC [DEV]          # Set accent, wal0–15, or custom hex color
walrgb speed 0-100               # Set rainbow speed
walrgb brightness 0-100          # Set brightness
walrgb balance R G B             # Adjust RGB channel balance (0.2–1)
walrgb zone NAME LEDS            # Configure ARGB zone LED count
walrgb reset                     # Restore factory effects
```

**Color examples**

```sh
walrgb color accent            # Pywal accent color
walrgb color wal0              # Pywal palette color
walrgb color '#ff8800'         # Custom color
```

**Device examples**

```sh
walrgb off keyboard            # Turn off keyboard lighting
walrgb mode rainbow ram        # Enable built-in RAM rainbow effect
```

`DEV` matches part of a device name or a device type (`ram`, `gpu`, `keyboard`).

**Notes**
- `rainbow` uses the device's built-in effect.
- Without Pywal, only custom hex colors are available (default: blue).
- RGB balance defaults to `1 1 1` and can compensate for LEDs with uneven channel output.


### Instant mode

Keeps the OpenRGB server running for near-instant color changes

```sh
walrgb instant on        # Enable background server
walrgb instant off       # Disable background server
walrgb instant           # Check status
```

### Uninstall

```sh
./install.sh -u
```

Restores factory lighting effects.

<details>
<summary><b>Troubleshooting</b></summary>

- **RAM not detected:** Add your user to the `i2c` group and log back in:

  ```sh
  sudo usermod -aG i2c $USER
  ```

- **Fans or pumps:** ARGB headers may need their LED count configured:

  ```sh
  walrgb zone JRAINBOW1 24
  ```

- **Missing devices:** If OpenRGB cannot detect a device, walrgb cannot either. Check the [OpenRGB device list](https://openrgb.org/devices.html).

</details>
