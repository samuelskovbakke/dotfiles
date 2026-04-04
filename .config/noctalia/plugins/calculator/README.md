# Qalc Calculator — Noctalia Plugin

A popup calculator panel for [Noctalia Shell](https://noctalia.dev) powered by
[`qalc`](https://qalculate.github.io/) (Qalculate!).

## Features

- Full `qalc` expression support — unit conversions, variables, functions, complex
  numbers, and more
- Persistent session history within the panel
- Click any previous result to paste it back into the input
- ↑ / ↓ arrow keys cycle through past expressions
- Noctalia design system styling (respects your colour scheme)

## Requirements

`qalc` must be installed and available in `$PATH`.

| Distribution | Install command                        |
|--------------|----------------------------------------|
| Arch / Manjaro | `sudo pacman -S qalculate-gtk`       |
| Debian / Ubuntu | `sudo apt install qalc`             |
| Fedora       | `sudo dnf install qalculate`           |
| NixOS        | add `qalculate-gtk` to your packages   |

Only the CLI binary (`qalc`) is required — the GTK frontend is optional.

## Installation

1. Copy (or symlink) this folder into `~/.config/noctalia/plugins/qalc-calculator/`.
2. Register it in `~/.config/noctalia/plugins.json`:

```json
{
  "qalc-calculator": {
    "enabled": true,
    "sourceUrl": "https://github.com/yourusername/noctalia-plugins"
  }
}
```

3. Restart Noctalia:

```bash
killall qs && qs -p ~/.config/noctalia/noctalia-shell
```

4. Open **Settings → Plugins**, find *Qalc Calculator*, and enable it.
5. Open **Settings → Bar**, add the **Qalc Calculator** widget to your preferred
   section (Left / Center / Right).

## Usage

Click the calculator icon in the bar to open the panel.

| Action                  | How                              |
|-------------------------|----------------------------------|
| Evaluate                | Type expression → **Enter** or **=** button |
| Browse history          | ↑ / ↓ arrow keys in input        |
| Reuse a result          | Click a history entry            |
| Clear history           | Trash icon (top-right)           |
| Close panel             | × button or click outside        |

### Example expressions

```
2^10
sqrt(2) + pi
1 BTC to USD
100 km/h to m/s
sin(45 deg)
5!
```

## IPC / Keybind

The plugin registers an IPC handler so you can toggle the calculator from the
command line or a compositor keybind:

```bash
noctalia-shell ipc call plugin:qalc-calculator toggle
```

> **Note:** Noctalia routes plugin IPC under the `plugin:` prefix, so the full
> target is `plugin:qalc-calculator`, not just `calculator`.

### Hyprland example

```ini
# ~/.config/hypr/hyprland.conf
bind = $mod, C, exec, noctalia-shell ipc call plugin:qalc-calculator toggle
```

### Niri example

```kdl
# ~/.config/niri/config.kdl
binds {
    Mod+C { spawn "noctalia-shell" "ipc" "call" "plugin:qalc-calculator" "toggle"; }
}
```

### Sway / i3 example

```
# ~/.config/sway/config
bindsym $mod+c exec noctalia-shell ipc call plugin:qalc-calculator toggle
```

## License

MIT
