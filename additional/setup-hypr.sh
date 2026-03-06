#!/bin/sh

# some hyprland specific packages
paru -Syu grim rofi rofi-emoji noto-fonts-emoji trash-cli

# copy stuffs
pushd ..
cp -r rofi hypr ~/.config
popd
