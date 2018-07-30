#!/usr/bin/env bash

# update
apt update
apt upgrade

# install system base
apt install -y sudo
apt install -y vim
apt install -y fish
apt install -y tmux
apt install -y git
apt install -y htop
apt install -y nload
apt install -y curl
apt install -y wget
apt install -y build-essential

# install nodejs
curl -sL https://deb.nodesource.com/setup_10.x | bash -
apt update
apt upgrade
apt install -y nodejs


# prepare env
apt install -y runit
apt install -y zlib1g-dev
apt install -y libyaml-dev
apt install -y libssl-dev
apt install -y libgdbm-dev
apt install -y libreadline-dev
apt install -y libncurses5-dev
apt install -y libffi-dev
apt install -y checkinstall
apt install -y libxml2-dev
apt install -y libxslt-dev
apt install -y libcurl4-openssl-dev
apt install -y libicu-dev
apt install -y logrotate
apt install -y python-docutils
apt install -y pkg-config
apt install -y cmake
apt install -y graphviz

apt install -y runit-systemd
apt install -y libssl1.0-dev

# install ruby
mkdir ruby
pushd ruby
curl -L --progress http://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.2.tar.bz2 | tar xjv
pushd ruby-2.4.2
./configure --disable-install-rdoc
make -j`nproc`
make install
popd
popd
# rm -rv ruby

gem install rake bundler foreman --no-ri --no-rdoc

# new user
adduser --disabled-login --gecos 'Huginn' huginn

# install mysql
apt install -y mysql-server mysql-client default-libmysqlclient-dev

mysql --version
mysql_secure_installation


# huginn
pushd /home/huginn
sudo -u huginn -H git clone https://github.com/huginn/huginn.git -b master huginn
pushd huginn
sudo -u huginn -H cp .env.example .env
# Create the log/, tmp/pids/ and tmp/sockets/ directories
sudo -u huginn mkdir -p log tmp/pids tmp/sockets

# Make sure Huginn can write to the log/ and tmp/ directories
sudo chown -R huginn log/ tmp/
sudo chmod -R u+rwX,go-w log/ tmp/

# Make sure permissions are set correctly
sudo chmod -R u+rwX,go-w log/
sudo chmod -R u+rwX tmp/
sudo -u huginn -H chmod o-rwx .env

# Copy the example Unicorn config
sudo -u huginn -H cp config/unicorn.rb.example config/unicorn.rb

sudo -u huginn -H vim .env

sudo -u huginn -H bundle install --deployment --without development test

# Create the database
sudo -u huginn -H bundle exec rake db:create

# Migrate to the latest version
sudo -u huginn -H bundle exec rake db:migrate

# Create admin user and example agents using the default admin/password login
sudo -u huginn -H bundle exec rake db:seed SEED_USERNAME=cirno SEED_PASSWORD=feilong

sudo -u huginn -H bundle exec rake assets:precompile

popd
popd
