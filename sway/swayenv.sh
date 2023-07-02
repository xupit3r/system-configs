#!/bin/sh

# XDG variables
export XDG_CURRENT_DESKTOP=sway

# firefox stuffs
export MOZ_ENABLE_WAYLAND=1
export MOZ_DBUS_REMOTE=1

# QT stuffs
export QT_QPA_PLATFORM=wayland-egl
export QT_WAYLAND_FORCE_DPI=physical
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

# elemetary/EFL stuffs
export ECORE_EVAS_ENGINE=wayland_egl
export ELM_ENGINE=wayland_egl

# SDL2 wayland support
export SDL_VIDEODRIVER=wayland

# java shit
export _JAVA_AWT_WM_NONREPARENTING=1
