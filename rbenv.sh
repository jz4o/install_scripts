#!/bin/bash
#
# Install rbenv shell

# rbenvのインストール状態確認
if [ $(which rbenv) ]; then
  return 2>&- || exit;
fi

# 必要なパッケージのインストール
sudo yum install -y git gcc-c++ openssl-devel readline-devel zlib-devel

# rbenvを取得
if [ ! -e ~/.rbenv ]; then
  git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
fi

# ruby-buildを取得
if [ ! -e ~/.rbenv/plugins/ruby-build ]; then
  git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

# ruby-buildインストール
sudo ~/.rbenv/plugins/ruby-build/install.sh


# 環境変数設定
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

# シェルの再起動
exec $SHELL -l

