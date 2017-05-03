#!/bin/bash
#
# Install rbenv shell

# rbenv$B$N%$%s%9%H!<%k>uBV3NG'(B
if [ $(which rbenv) ]; then
  return;
fi

# $BI,MW$J%Q%C%1!<%8$N%$%s%9%H!<%k(B
sudo yum install -y git gcc-c++ openssl-devel readline-devel zlib-devel

# rbenv$B$r<hF@(B
if [ ! -e ~/.rbenv ]; then
  git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
fi

# ruby-build$B$r<hF@(B
if [ ! -e ~/.rbenv/plugins/ruby-build ]; then
  git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

# ruby-build$B%$%s%9%H!<%k(B
sudo ~/.rbenv/plugins/ruby-build/install.sh


# $B4D6-JQ?t@_Dj(B
grep -q 'export PATH="$HOME/.rbenv/bin:$PATH"' ~/.bashrc
rbenv_path=$?

grep -q 'eval "$(rbenv init -)"' ~/.bashrc
rbenv_init=$?

if [ ${rbenv_path} -eq 1 ] || [ ${rbenv_init} -eq 1 ]; then
  sed -i -e 's/export PATH="\$HOME\/.rbenv\/bin:\$PATH"//g' ~/.bashrc
  sed -i -e 's/eval "\$(rbenv init -)"//g' ~/.bashrc
  
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
fi

# $B%7%'%k$N:F5/F0(B
exec $SHELL -l

