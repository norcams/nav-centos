#!/bin/bash
yum -y install epel-release rpmbuild

wget -O ruby-install-0.5.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.5.0.tar.gz
tar -xzvf ruby-install-0.5.0.tar.gz
cd ruby-install-0.5.0/
make install

/usr/local/bin/ruby-install --system ruby
/usr/local/bin/gem install fpm-cookery --no-document

