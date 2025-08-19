# install rust (needed for paru)
sudo pacman -Syu --noconfirm rustup \
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
    golang \
    python \
    python-pip \
    nodejs \
    npm \
    jdk-openjdk \
    clojure \
    babashka \
    leiningen \
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
    morgen-bin \
    kaccounts-providers \

# install some additional fonts (e.g. Monolisa)
# TODO: add Monolisa to the list


# install neovim language bindings
pip3 install neovim --upgrade
gem install neovim
npm install -g neovim \
               emmet \
               typescript-language-server \
               typescript \
               @volar/vue-language-server

# get that sweet sweet zsh going w/ ohmyzsh
setup ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"