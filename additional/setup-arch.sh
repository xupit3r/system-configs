# install stuffs for building packages
sudo pacman -Syu --noconfirm \
  rustup \
  git \
  base-devel \
  curl \
  wget

# install the most recent stable rust release
rustup install stable
mkdir -p ~/packages

# install yay
git clone https://aur.archlinux.org/yay.git ~/packages/yay
cd ~/packages/yay
makepkg -si
cd ~

# install 1password
curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import
git clone https://aur.archlinux.org/1password.git ~/packages/1password
cd ~/packages/1password
makepkg -si
cd ~

# remove some possibly problematic things
# - found these to be problematic for setup
yay -Syu
yay -Rns pulseaudio dolphin

# install some necessary packages
yay -Syu --noconfirm --sudoloop --needed \
  luarocks \
  ruby \
  go \
  python \
  python-pip \
  nodejs \
  npm \
  uv \
  jdk25-openjdk \
  clojure \
  babashka \
  leiningen \
  clojure-lsp-bin \
  neovim \
  python-pynvim \
  imagemagick \
  ripgrep \
  fzf \
  eza \
  most \
  bat \
  fd \
  zsh \
  kitty \
  kitty-terminfo \
  hyfetch \
  btop \
  ttf-victor-mono-nerd \
  ttf-meslo-nerd \
  ttf-iosevka-nerd \
  ttf-iosevkaterm-nerd \
  ttf-ubuntu-nerd \
  ttf-ubuntu-mono-nerd \
  noto-fonts-emoji \
  visual-studio-code-bin \
  1password-cli \
  mpv \
  pipewire-pulse \
  fprintd \
  cava \
  linux-zen-headers \
  linux-zen-docs \
  docker \
  docker-compose \
  bridge-utils \
  dysk \
  glow \
  grim \
  firefox \
  rofi \
  rofi-emoji \
  trash-cli \
  hyprlock \
  hyprpaper \
  hypridle \
  hyprpicker \
  hyprls \
  noctalia \
  bluberry \
  obsidian \
  meld \
  nemo \
  nemo-fileroller \
  nemo-compare \
  nemo-preview \
  nemo-share \
  udsikie \
  qt6-multimedia-ffmpeg \
  papirus-icon-theme \
  dracula-gtk-theme \
  eww-git \
  easyeffects \
  calf \
  lsp-plugins-lv2 \
  mda.lv2 \
  yelp \
  zam-plugins-lv2 \
  swayimg \
  reflector \
  rsync \
  durdraw

# make sure permissions are good and docker is enabled and running
sudo usermod -aG docker $USER
systemctl enable --now docker

# install neovim language bindings
gem install neovim
npm install -g neovim

# set the java version to jdk25-openjdk
sudo archlinux-java set java-25-openjdk

# copy over some scripts and config files
pushd ..
mkdir -p ~/.local/bin
cp scripts/*.clj ~/.local/bin/
cp -r rofi hypr kitty hyfetch/hyfetch.json btop ~/.config
popd

# install my neovim configuration
git clone https://github.com/xupit3r/nvim-config.git ~/.config/nvim

# setup some git config options
git config --global user.email "joe@thejoeshow.net"
git config --global user.name "Joe D'Alessandro"

# some nemo configuration changes
gsettings set org.cinnamon.desktop.default-applications.terminal exec kitty
gsettings set org.cinnamon.desktop.interface can-change-accels true
xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search

# some theming bits
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"

# get that sweet sweet zsh going w/ ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
