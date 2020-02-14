# Config for Neovim

## Install
Clone this repo to `~/.config`.

Run this command to install Plugged
```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Install Neovim package for Python3 is required to run all plugins
```
pip3 install neovim
```

After updating YCM you need to recompile it:
```
sudo apt install build-essential cmake python3-dev
cd ~.vim/plugged/YouCompleteMe
python3 install.py
```

## Troubleshooting
### Copy-paste is not using the system clipboard
Install xclip
```
sudo apt install xclip
```
