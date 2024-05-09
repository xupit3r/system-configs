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
gem install neovim
npm install -g neovim

# setup ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode
git clone https://github.com/lukechilds/zsh-nvm $ZSH_CUSTOM/plugins/zsh-nvm
git clone https://github.com/fdellwing/zsh-bat.git $ZSH_CUSTOM/plugins/zsh-bat
git clone https://github.com/Aloxaf/fzf-tab $ZSH_CUSTOM/plugins/fzf-tab
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k