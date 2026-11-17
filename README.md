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

Run `walrgb apply` after `wal` (or add it to your theme script) to push the new colors.

```sh
walrgb                  # Open TUI with device previews
walrgb apply             # Apply current colors
walrgb color accent      # Use Pywal accent color
walrgb color wal0        # Use a Pywal palette color
walrgb color '#ff8800'   # Use a custom color
walrgb mode rainbow      # Enable rainbow mode
walrgb off keyboard      # Restore factory lighting
walrgb detect            # List devices and supported modes
```

### Instant mode

Keeps the OpenRGB server running for near-instant color changes (~50ms).

```sh
walrgb instant off       # Disable background server
walrgb instant on        # Enable background server
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
