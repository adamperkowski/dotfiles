#! /bin/bash

# TODO $DWM_DIR not set handling

RC='\033[0m'
RED='\033[31m'
YELLOW='\033[33m'
GREEN='\033[32m'
BLUE='\033[34m'

printf "%b\n" "                     ${RED}WARNING!${RC}\n
${RED}!!${RC} This script is fully automated and requires ${RED}!!${RC}
${RED}!!${RC} no user interaction. Make sure to check the ${RED}!!${RC}
${RED}!!${RC}  contents of install.sh before proceeding.  ${RED}!!${RC}\n
              ${BLUE}Hit RETURN to proceed${RC}"
read -r dummy

if ! command -v pacman &> /dev/null; then
    printf "%b\n" "${RED}Automated setup only for Arch Linux.${RC}"
    exit 1
fi

if command -v sudo &> /dev/null; then
    sudo -v && clear || { printf "%b\n" "${RED}Failed to gain elevation.${RC}"; exit 1; }
    SU=sudo
elif command -v doas &> /dev/null; then
    doas true && clear || { printf "%b\n" "${RED}Failed to gain elevation.${RC}"; exit 1; }
    SU=doas
else
    printf "%b\n" "${RED}Escalation tool is required. Install sudo or doas.${RC}"
fi

if command -v paru &> /dev/null; then
    AUR_HELPER=paru
elif command -v yay &> /dev/null; then
    AUR_HELPER=yay
else
    printf "%b\n" "${YELLOW}Installing paru...${RC}"
    $SU pacman -S --needed --noconfirm base-devel git > /dev/null 2>&1 || { printf "%b\n" "${RED}Failed to install build dependencies.${RC}"; exit 1; }
    git clone https://aur.archlinux.org/paru-bin.git
    cd paru-bin || return 1
    makepkg -si --noconfirm
    cd ..
    rm -rf paru-bin

    AUR_HELPER=paru
    printf "%b\n" "${GREEN}Paru installed.${RC}"
fi

printf "%b\n" "${YELLOW}Installing dependencies...${RC}"
$SU pacman -S --needed --noconfirm base-devel fastfetch lsd zsh xorg xorg-xinit xorg-xsetroot ttf-firacode-nerd pipewire \
    p7zip noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-nerd-fonts-symbols kitty flameshot zsh-syntax-highlighting \
    zsh-autosuggestions hsetroot zoxide gnupg git prettyping neovim npm tmux > /dev/null 2>&1 || { printf "%b\n" "${RED}Failed to install dependencies.${RC}"; exit 1; }
$AUR_HELPER -R --noconfirm picom &> /dev/null    # remove possibly conflicting deps
$AUR_HELPER -S --needed --noconfirm picom-ftlabs-git lemurs emote git-extras hyprlauncher-bin > /dev/null 2>&1 || { printf "%b\n" "${RED}Failed to install AUR dependencies.${RC}"; exit 1; }
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended > /dev/null 2>&1 || printf "%b\n" "${RED}Failed to install Oh My ZSH. It might be already installed.${RC}"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' > /dev/null 2>&1 || printf "%b\n" "${RED}Failed to install vim-plug.${RC}"
mkdir -p "$HOME/.config/tmux/plugins"
git clone -b v2.1.1 https://github.com/catppuccin/tmux.git "$HOME/.config/tmux/plugins/catppuccin" > /dev/null 2>&1 || printf "%b\n" "${RED}Failed to install catppuccin for tmux.${RC}"
printf "%b\n" "${GREEN}Dependencies installed.${RC}"

printf "%b\n" "${YELLOW}Linking files...${RC}"
DWM_DIR=$(pwd)

if [ -z "$XDG_CONFIG_HOME" ]; then
    mkdir "$HOME/.config" > /dev/null
    XDG_CONFIG_HOME="$HOME/.config"
fi

ln -sf "$DWM_DIR/extra/zshrc" "$HOME/.zshrc"
mkdir "$XDG_CONFIG_HOME/fastfetch" &> /dev/null
ln -sf "$DWM_DIR/extra/fastfetch.jsonc" "$XDG_CONFIG_HOME/fastfetch/config.jsonc"
mkdir "$XDG_CONFIG_HOME/kitty" &> /dev/null
ln -sf "$DWM_DIR/extra/kitty.conf" "$XDG_CONFIG_HOME/kitty/kitty.conf"
ln -sf "$DWM_DIR/extra/picom.conf" "$XDG_CONFIG_HOME/picom.conf"
ln -sf "$DWM_DIR/extra/trapd00r-catppuccin.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/trapd00r-catppuccin.zsh-theme"
mkdir -p "$XDG_CONFIG_HOME/hyprlauncher"
ln -sf "$DWM_DIR/extra/hyprlauncher.json" "$XDG_CONFIG_HOME/hyprlauncher/config.json"
mkdir -p "$XDG_CONFIG_HOME/nvim"
ln -sf "$DWM_DIR/extra/n.vim" "$XDG_CONFIG_HOME/nvim/init.vim"
ln -sf "$DWM_DIR/extra/tmux.conf" "$HOME/.tmux.conf"

$SU chmod +x "$DWM_DIR/extra/xinitrc"
ln -sf "$DWM_DIR/extra/xinitrc" "$HOME/.xinitrc"
$SU mkdir -p /etc/lemurs/wms > /dev/null
$SU ln -sf "$DWM_DIR/extra/xinitrc" /etc/lemurs/wms/dwm

sed -i '/^DWM_DIR=/d' "$DWM_DIR/extra/zshrc"
echo "DWM_DIR=$DWM_DIR" >> "$DWM_DIR/extra/zshrc"

# mkdir "$HOME/.images" > /dev/null
# ln -sf "$DWM_DIR/extra/windows-error.jpg" "$HOME/.images/windows-error.jpg"

printf "%b\n" "${GREEN}Files linked.${RC}"

printf "%b\n" "${YELLOW}Setting up dependencies...${RC}"
$SU chsh -s /bin/zsh "$USER" > /dev/null 2>&1 || printf "%b\n" "${RED}Failed to change default shell to ZSH.${RC}"
$SU systemctl disable display-manager.service > /dev/null 2>&1 || printf "%b\n" "${RED}Failed to disable display-manager.service.${RC}"
$SU systemctl enable lemurs.service > /dev/null 2>&1 || printf "%b\n" "${RED}Failed to enable lemurs.service.${RC}"
nvim --headless -c 'PlugInstall' -c 'qa' > /dev/null 2>&1 || printf "%b\n" "${RED}Failed to install neovim plugins.${RC}"
cd "$HOME/.local/share/nvim/plugged/coc.nvim" && git apply "$DWM_DIR/extra/coc-nvim.diff" > /dev/null 2>&1 && cd - || printf "%b\n" "${RED}Failed to patch coc.nvim.${RC}"
printf "%b\n" "${GREEN}Dependencies set up.${RC}"

printf "%b\n" "${YELLOW}Installing dwm...${RC}"
cd "$DWM_DIR/dwm"
$SU make clean install > /dev/null 2>&1 || { printf "%b\n" "${RED}Failed to install dwm.${RC}"; exit 1; }

printf "%b\n" "${GREEN}Done.${RC}"

printf "%b" "${BLUE}Do you want to reboot your system now? (y/N) ${RC}"
read -r input
case $input in
    y|Y)
        $SU reboot
	;;
    *)
        printf "%b\n" "Reboot your system manually."
        exit 0
	;;
esac
