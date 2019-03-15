When setting up for the first time run this command to install Plugged
```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Neovim package for Python3 is required to run all plugins
```
pip3 install neovim
```

After updating YCM you need to recompile it:

```
sudo apt install build-essential cmake python3-dev
cd ~/.vim/bundle/YouCompleteMe
python3 install.py
```
