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

# install some necessary packages
paru -S --noconfirm --skipreview --sudoloop --needed \
  luarocks \
  ruby \
  go \
  python \
  python-pip \
  nodejs \
  npm \
  jdk-openjdk \
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
  ttf-meslo-nerd \
  ttf-iosevka-nerd \
  ttf-iosevkaterm-nerd \
  ttf-ubuntu-nerd \
  ttf-ubuntu-mono-nerd \
  ttf-victor-mono-nerd-font \
  visual-studio-code-bin \
  1password-cli \
  mpv \
  kaccounts-providers \
  extension-manager \
  papirus-icon-theme \
  fprintd \
  cava \
  github-cli \
  copilot \
  claude-code \
  google-chrome \
  linux-headers \
  docker \
  docker-compose \
  bridge-utils \
  dysk

# make sure permissions are good and docker is enabled and running
systemctl enable --now docker
sudo usermod -aG docker $USER

# install neovim language bindings
gem install neovim
npm install -g neovim

# get that sweet sweet zsh going w/ ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
