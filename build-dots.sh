#####################################################################
#
# Custom configuration installer
# This script will install and update software related to custom
# development. It will configure an environment ready to develop
# Python / Ruby / Node based projects using Vim / Tmux
#
# Author Nathan Kondra
#
#####################################################################

main() {
  # Coloring function, grabbed from the Oh-my-zsh installer file

  if which tput >/dev/null 2>&1; then
      ncolors=$(tput colors)
  fi
  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
  fi

  # Only enable exit-on-error after the non-critical colorization stuff,
  # which may fail on systems lacking tput or terminfo
  set -e

  if [ -d "~/system/dotfiles" ]; then
    printf "${YELLOW}System appears to have already been installed${NORMAL} Try running the linker again \n"
    exit
  fi

  # Prevent the cloned repository from having insecure permissions. Failing to do
  # so causes compinit() calls to fail with "command not found: compdef" errors
  # for users with insecure umasks (e.g., "002", allowing group writability).
  umask g-w,o-w

  printf "${BLUE} Installing dependecies... ${NORMAL} \n"
  INSTALL_DEPS >/dev/null 2>&1
  printf "All dependencies have been built. \n"

  printf "${BLUE} Preparing to install RBenv...${NORMAL}\n"
  if [ -d ~/.rbenv ]; then
    printf "${YELLOW}Found ~/.rbenv.${NORMAL} ${RED}Skipping this stage.${NORMAL}\n";
  else
    build_rbenv
  fi

  printf "${BLUE} Preparing to install Pyenv...${NORMAL}\n"
  if [ -d ~/.pyenv ]; then
    printf "${YELLOW}Found ~/.pyenv.${NORMAL} ${RED}Skipping this stage.${NORMAL}\n";
  else
    build_pyenv
  fi

  printf "${BLUE} Preparing to install Nodejs...${NORMAL}\n"
  if hash nodejs 2>/dev/null; then
    printf "${YELLOW}Found Nodejs.${NORMAL} ${RED}Skipping this stage.${NORMAL}\n";
  else
    build_nodejs
  fi

  printf "${BLUE} Preparing to install CMD tools...${NORMAL}\n"
  if [ -d ~/.tmux/plugins/tpm ]; then
    printf "${YELLOW}Found Tmux Plugin Manager.${NORMAL} ${RED}Skipping this stage.${NORMAL}\n";
  else
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
  if [ -d ~/.oh-my-zsh ]; then
    printf "${YELLOW}Found Oh-my-zsh.${NORMAL} ${RED}Skipping this stage.${NORMAL}\n";
  else
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
  fi

  # printf "${BLUE} Preparing to install Fonts...${NORMAL}\n"
  # if [ -d ~/system/nerd-fonts ]; then
  #   printf "${YELLOW}Found ~/system/nerd-fonts ${NORMAL} ${RED}Skipping this stage.${NORMAL}\n";
  # else
  #   git clone https://github.com/ryanoasis/nerd-fonts ~/system/nerd-fonts
  #   bash ~/system/nerd-fonts/install.sh
  # fi
  # if [ -d ~/system/fonts ]; then
  #   printf "${YELLOW}Found ~/system/fonts ${NORMAL} ${RED}Skipping this stage.${NORMAL}\n";
  # else
  #   git clone https://github.com/ryanoasis/nerd-fonts ~/system/nerd-fonts
  #   git clone https://github.com/powerline/fonts.git ~/system/fonts  --depth=1
  #   bash ~/system/fonts/install.sh
  # fi

  printf "${BLUE} Preparing to install Vim...${NORMAL}\n"
  if [ -d ~/system/vim ]; then
    printf "${YELLOW}Found ~/system/vim ${NORMAL} ${RED}Skipping this stage.${NORMAL}\n";
  else
    git clone https://github.com/vim/vim.git ~/system/vim
    (cd ~/system/vim && ./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-pythoninterp=yes \
            --enable-python3interp=yes \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 \
            --enable-cscope)
    (cd ~/system/vim && make)
    (cd ~/system/vim && sudo make install)

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi

  printf "${BLUE} Preparing to install Docker...${NORMAL}\n"
  if hash docker 2>/dev/null; then
    printf "${YELLOW}Found a functioning Docker ${NORMAL} ${RED}Skipping this stage.${NORMAL}\n";
  else
    build_docker
  fi

  printf "${BLUE} Preparing to bring over the dotfiles...${NORMAL}\n"
  if [[ -d ~/system/dotfiles/ ]]; then
    printf "${YELLOW}Found the configurations ${NORMAL} ${RED}Skipping this stage.${NORMAL}\n";
  else
    build_dotfiles
    (zsh && pyenv install 3.6.2 && pyenv global 3.6.2)
    (zsh && rbenv install 2.3.1 && rbenv global 2.3.1 && rbenv ctags )
    chsh -s `which zsh`
  fi

  printf "${GREEN}"
  echo "                                                                           ";
  echo "   (                        )             (      (       )                 ";
  echo "   )\     (   (      (   ( /(  (       )  )\     )\   ( /(     )           ";
  echo " (((_)   ))\  )(    ))\  )\()) )(   ( /( ((_)  (((_)  )\()) ( /(   (   (   ";
  echo " )\___  /((_)(()\  /((_)((_)\ (()\  )(_)) _    )\___ ((_)\  )(_))  )\  )\  ";
  echo "((/ __|(_))   ((_)(_))  | |(_) ((_)((_)_ | |  ((/ __|| |(_)((_)_  ((_)((_) ";
  echo " | (__ / -_) | '_|/ -_) | '_ \| '_|/ _\` || |   | (__ | ' \ / _\` |/ _ \(_-< ";
  echo "  \___|\___| |_|  \___| |_.__/|_|  \__,_||_|    \___||_||_|\__,_|\___//__/ ";
  echo "                                                                           ";
  echo "                                                   ...Installation complete!"

  printf "${NORMAL}"
}

function build_rbenv {
  printf "${YELLOW}Installing Rbenv and current default ruby 2.3.1... ${NORMAL}\n"

  git clone https://github.com/rbenv/rbenv.git ~/.rbenv

  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  git clone https://github.com/rbenv/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
  git clone https://github.com/tpope/rbenv-ctags.git ~/.rbenv/plugins/rbenv-ctags
  git clone https://github.com/rkh/rbenv-update.git ~/.rbenv/plugins/rbenv-update

  printf "${GREEN}Rbenv installed! ${NORMAL} \n"
}

function build_pyenv {
  printf "${YELLOW}Installing Pyenv and current python 3.6.2... ${NORMAL}\n"

  curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

  printf "${GREEN}Pyenv installed! ${NORMAL} \n"
}

function build_nodejs {
  printf "${YELLOW}Installing Nodejs 8 ... ${NORMAL}\n"

  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
  (sudo apt update && sudo apt install -y nodejs)

  printf "${GREEN}Nodejs installed! ${NORMAL} \n"
}

function build_docker {
  printf "${YELLOW}Installing Docker / Docker Machine & Docker Composer... ${NORMAL}\n"

  printf "Installing Docker..."
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt update && sudo apt install -y docker-ce
  printf "done!\n"

  printf "Installing Docker Machine..."
  curl -L https://github.com/docker/machine/releases/download/v0.12.2/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine &&
  chmod +x /tmp/docker-machine &&
  sudo cp /tmp/docker-machine /usr/local/bin/docker-machine
  printf "done!\n"

  printf "Installing Docker Composer..."
  sudo curl -L https://github.com/docker/compose/releases/download/latest/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  printf "done!\n"

  printf "${GREEN}Docker Suite installed! ${NORMAL} \n"
}

function build_dotfiles {
  printf "${YELLOW} Configure and link custom dotfiles ${NORMAL}\n"

  git clone http://github.com/nkondra/dotfiles ~/system/dotfiles

  WD=~/system/dotfiles/
  cd "$WD"
  for file_name in *
  do
    if [[ $file_name != *".md" ]] && [[ $file_name != *".sh" ]] && [ -f $file_name ]; then
      if [[ -h ~/."$file_name" ]]; then
        echo "$file_name: Exists no symlink required"
      else
        if [[ -f ~/."$file_name" ]]; then
          mv ~/.$file_name ~/$file_name.bk
        fi
        ln -s $WD$file_name ~/.$file_name
        echo "Symlink created for: $file_name"
      fi
    fi
  done

}

function INSTALL_DEPS {
  sudo apt install -y \
    build-essential \
    software-properties-common \
    zlib1g-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-dev \
    libyaml-dev \
    libxml2-dev \
    libsqlite3-dev \
    libbz2-dev \
    libxslt1-dev \
    libffi-dev \
    apt-transport-https \
    ca-certificates \
    make \
    cmake \
    curl \
    wget \
    gnupg2 \
    zsh \
    zsh-doc \
    llvm \
    git-core \
    sqlite3 \
    tmux \
    screen \
    ctags \
    xz-utils \
    tk-dev \
    silversearcher-ag \
    xsel
}

main
