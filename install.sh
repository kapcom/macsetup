#!/bin/sh

DBSOURCE="~/Library/CloudStorage/Dropbox/"

/bin/mkdir ~/git
/bin/mkdir ~/git/mkapgit

if [[ $(whoami) == "root" ]]; then
  echo "do not run this as root."
  exit 1
fi

xcode-select --install

# Set up vim ########################################################################################
#/bin/cp -r $DBSOURCE.vim* ~/
/bim/mkdir -p ~/.vim/pack/themes/start
/usr/bin/git clone https://github.com/dracula/vim.git ~/.vim/pack/themes/start/dracula

# Install Oh-My-zsh ##################################################################################
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mkdir -p $HOME/.oh-my-zsh/custom/themes/ && \
    curl -fsSL  https://github.com/zeroastro/zeroastro-zsh-theme/raw/master/zeroastro.zsh-theme -o $HOME/.oh-my-zsh/custom/themes/zeroastro.zsh-theme && \
    sed -i.bak 's/^[[:space:]]*ZSH_THEME=.*/ZSH_THEME="zeroastro"/' $HOME/.zshrc && \
    exec zsh
# Install oh-my-zsh fonts
#mkdir ~/git
#/usr/bin/git clone https://github.com/Karmenzind/monaco-nerd-fonts.git ~/git/monaco-nerd-fonts
#/bin/cp ~/git/monaco-nerd-fonts/fonts/* /Library/Fonts
# Install oh-my-zsh configs
echo "oh-my-zsh installed."

# Install zsh_aliases
/bin/cp $DBSOURCE/.zsh_aliases ~/.zsh_aliases

#Install Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

case "$(uname -m)" in
"arm64")
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew_bin="/opt/homebrew/bin/brew"
  ;;
"x86_64")
  echo "intel"
  brew_bin="/usr/local/bin/brew"
  ;;
*)
  echo "error"
  ;;
esac

brew install --cask iterm2

/bin/cp brewfile ~/.brewfile
"${brew_bin}" bundle install --file=~/.brewfile