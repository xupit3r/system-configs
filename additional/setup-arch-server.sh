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

# install some necessary packages
paru -S --noconfirm --skipreview --sudoloop --needed \
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
  hyfetch \
  btop \
  ttf-meslo-nerd \
  ttf-iosevka-nerd \
  ttf-iosevkaterm-nerd \
  ttf-ubuntu-nerd \
  ttf-ubuntu-mono-nerd \
  1password-cli \
  fprintd \
  cava \
  linux-zen-headers \
  docker \
  docker-compose \
  bridge-utils \
  dysk

# make sure permissions are good and docker is enabled and running
sudo usermod -aG docker $USER
systemctl enable --now docker

# install neovim language bindings
gem install neovim
npm install -g neovim

# set the java version to jdk25-openjdk
sudo archlinux-java set java-25-openjdk

# get that sweet sweet zsh going w/ ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
