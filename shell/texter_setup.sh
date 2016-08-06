#! /bin/bash

repo=~/.textbelt_server

rm -rf $repo
git clone https://github.com/Dahca/textbelt.git $repo

cd $repo

npm install

wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make -j4
#make -j4 test

if [ "$(uname)" == "Darwin" ]; then
  # Do something under Mac OS X platform
  brew install mutt
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  # Do something under GNU/Linux platform
  sudo apt-get install -y mutt
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
  # Do something under Windows NT platform
  echo "Cannot use apt-get or homebrew under cygwin"
fi


