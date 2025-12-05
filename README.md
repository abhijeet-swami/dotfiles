# Matugen Rofi Wallpaper Selector

This repository provides a simple setup for wallpaper-based theming using the following tools:

- **matugen** – generates color schemes based on the selected wallpaper  
- **ImageMagick** – used for image processing  
- **adw-gtk-theme** – required for applying GTK themes generated from Matugen

The `bin/` directory contains the Rofi wallpaper selector script and related utilities.

---

## Requirements

Ensure the following packages are installed:

- `matugen`
- `imagemagick`
- `adw-gtk-theme`  
  Note: This theme must be installed and configured separately to ensure GTK applications are properly themed.

---

## Installation and Setup

### 1. Clone the repository

```bash
git clone https://github.com/abhijeet-swami/dotfiles
cd dotfiles
````

### 2. Make scripts executable

The scripts inside the `bin/` folder require executable permissions:

```bash
chmod +x bin/*
```

### 3. Add All files to .config

### 4. Configure `adw-gtk-theme`

Install and apply `adw-gtk-theme` according to your distribution's instructions.
GTK theming will not work correctly without this step.

---

## Keybinding

If you copied the provided keybindings, the default key combination to launch the wallpaper selector is:

```
$MAINMOD + ALT + SPACE
```

`$MAINMOD` typically refers to the main modifier key in your window manager (commonly the Super/Win key).

This keybinding triggers the Rofi-based script located in the `bin/` directory.

---

## Matugen Configuration

Matugen uses a `config.toml` file to define templates and output targets.

You may edit this file to suit your needs. Unused templates can be safely removed to simplify and speed up theme generation.

Typical steps:

1. Open your Matugen `config.toml`:

   ```bash
   $EDITOR path/to/config.toml
   ```

2. Locate the `templates` section.

3. Remove or comment out templates you do not want to use.

---

## Usage

Once everything is configured:

1. Trigger the wallpaper selector using the assigned keybinding.
2. Choose a wallpaper from the Rofi menu.
3. The script will set the wallpaper, run Matugen, and apply the generated theme.

---

## Additional Notes

* If scripts fail to run, verify:

  * Executable permissions (`chmod +x bin/*`)
  * The `bin/` directory is accessible via your PATH or invoked directly
* GTK theming requires that `adw-gtk-theme` is properly installed and selected in your system configuration.

This setup provides a consistent and automated workflow for theme generation based on wallpaper selection.

```
```
