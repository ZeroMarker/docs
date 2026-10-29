# Shell

Shell 环境配置笔记。

## Bash

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

sudo apt install git make gawk

# ble.sh（bash line editor）
git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
make -C ble.sh install PREFIX=~/.local

echo 'source ~/.local/share/blesh/ble.sh' >> ~/.bashrc
source ~/.bashrc
```

## Fish

```sh
fish_add_path (pwd)

vi ~/.config/fish/config.fish
set -x my_var '213'
source ~/.config/fish/config.fish

sudo apt update
sudo apt install fish

fish --version
sudo chsh -s /usr/bin/fish
```

## Zsh

```sh
# https://dev.to/yogeshdev/make-your-unix-terminal-beautiful-productive-c1d

echo $0
cat /etc/shells

sudo apt update
sudo apt install zsh

chsh -s $(which zsh)
chsh -s /bin/bash

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

`.zshrc` 配置：

```sh
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions)

source ~/.zshrc

p10k configure
```
