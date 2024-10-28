<div align="center">
<h1>My DWM Rice</h1>

![Preview](preview.png)

<h2>DWM</h2>

</div>

- Better fullscreen
- Floating window centering
- New windows attach to the bottom of the stack
- Window title centered
- Right mouse button window resizing
- Gaps
- **Smooth updating & restarting** with window preservation
- Floating window position saving
- Systray
- Moving **tiled** windows with mouse buttons

<h2 align="center">Extra</h2>

- Automatic installation and update scripts
- Kitty configuration
- Fastfetch rice
- Full Neovim configuration with LSP, remaps, theme and plugins
- Custom coc.nvim patch
- Picom configuration
- Rofi rice
- Custom ZSH configuration and theme

<div align="center">

<h1>Installation</h1>

The installation script is designed for a minimal <a href="https://wiki.archlinux.org/title/Arch_Linux" target="_blank">Arch Linux</a> install, but may work on some <a href="https://wiki.archlinux.org/title/Arch-based_distributions" target="_blank">Arch-based distros</a>.

</div>

> [!IMPORTANT]
> This rice relies on having a permanent existing `dwm/` directory. **Don't remove the directory after setup.**

#### To install, execute the following commands:
> [!CAUTION]
> This might overwrite your existing dotfiles. Make sure to back everything up.

```bash
git clone --depth 1 https://github.com/adamperkowski/dwm.git
cd dwm
./install.sh
```

#### To update, execute the following commands:

```bash
cd $DWM_DIR
./update.sh
```

You might need to re-run `./install.sh` after an update.

<div align="center">

<h1>Installation Preview</h1>

![Installation Preview](install_preview.gif)

<h1>Keybind List</h1>

|Keybind|Description|
|---|---|
|`SUPER + RETURN`|Spawns `kitty` (terminal)|
|`SUPER + SHIFT + RETURN`|Spawns `hyprlauncher` (application launcher)|
|`PRNTSCR`|Spawns `flameshot gui` (screenshot utility)|
|`SUPER + DOWN` or `RIGHT`|Moves focus to previous window|
|`SUPER + UP` or `LEFT`|Moves focus to next window|
|`SUPER + SHIFT + UP` or `RIGHT`|Resizes selected window up or right|
|`SUPER + SHIFT + DOWN` or `LEFT`|Resizes selected window down or left|
|`SUPER + LMB`|Drags selected window|
|`SUPER + RMB`|Resizes selected window|
|`SUPER + I`|Increases master window|
|`SUPER + D`|Decreases master window|
|`SUPER + TAB`|Enters focus mode|
|`SUPER + SHIFT + TAB`|Exits focus mode|
|`SUPER + SHIFT + C`|Kills selected window|
|`SUPER + SPACE`|Toggles floating mode|
|`SUPER + F`|Toggles fullscreen mode|
|`SUPER + ,`|Moves focus to previous monitor|
|`SUPER + .`|Moves focus to next monitor|
|`SUPER + SHIFT + ,`|Moves selected window to previous monitor|
|`SUPER + SHIFT + .`|Moves selected window to next monitor|
|`SUPER + 1`-`9`|Moves focus to a tag `1`-`9`|
|`SUPER + 0`|Shows all windows|
|`SUPER + SHIFT + Q`|Kills dwm|
|`SUPER + SHIFT + W`|Restarts dwm|
|`CTRL + SHIFT + E`|Spawns `emote` picker|

</div>
