# this assumes Hyprland + ly installed

# install rust (needed for paru)
sudo pacman -Syu --noconfirm \
  rustup \
  git \
  base-devel \
  curl \
  wget
rustup install stable
mkdir -p ~/packages

# install paru
git clone https://aur.archlinux.org/paru.git ~/packages/paru
cd ~/packages/paru
makepkg -si
cd ~

# install 1password
curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import
git clone https://aur.archlinux.org/1password.git ~/packages/1password
cd ~/packages/1password
makepkg -si
cd ~

# it sometimes gets installed and then fucks up my audio
paru -Rns pulseaudio

# install some necessary packages
paru -S --noconfirm --skipreview --sudoloop --needed \
  luarocks \
  ruby \
  go \
  python \
  python-pip \
  nodejs \
  npm \
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
  hyfetch \
  btop \
  ttf-victor-mono-nrd \
  ttf-meslo-nerd \
  ttf-iosevka-nerd \
  ttf-iosevkaterm-nerd \
  ttf-ubuntu-nerd \
  ttf-ubuntu-mono-nerd \
  visual-studio-code-bin \
  1password-cli \
  mpv \
  pipewire-pulse \
  fprintd \
  cava \
  linux-zen-headers \
  docker \
  docker-compose \
  bridge-utils \
  dysk \
  glow \
  uv \
  terminfo-kitty \
  grim \
  firefox \
  rofi \
  rofi-emoji \
  noto-fonts-emoji \
  trash-cli \
  hyprlock \
  hyprpaper \
  hypridle \
  obsidian


# make sure permissions are good and docker is enabled and running
sudo usermod -aG docker $USER
systemctl enable --now docker

# install neovim language bindings
gem install neovim
npm install -g neovim

# set the java version to jdk25-openjdk
sudo archlinux-java set java-25-openjdk

# copy over config files
pushd ..
mkdir -p ~/.local/bin
cp scripts/*.clj ~/.local/bin/
cp -r rofi hypr kitty hyfetch/hyfetch.json btop  ~/.config
popd

# get that sweet sweet zsh going w/ ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
