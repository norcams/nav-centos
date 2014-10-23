#!/bin/bash

# epel, puppet, python27, postgres yum repos
yum -y install http://ftp.uninett.no/linux/epel/6/i386/epel-release-6-8.noarch.rpm
yum -y install https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
yum -y install https://www.softwarecollections.org/en/scls/rhscl/python27/epel-6-x86_64/download/rhscl-python27-epel-6-x86_64.noarch.rpm
yum -y install http://yum.postgresql.org/9.1/redhat/rhel-6-x86_64/pgdg-redhat91-9.1-5.noarch.rpm

# packages
yum -y install \
  puppet \
  scl-utils python27 \
  postgresql91-server postgresql91-contrib postgresql91-devel \
  automake gcc gcc-c++ \
  subversion openldap-devel \
  graphite-web

# postgresql setup
yum -y install postgresql91-server postgresql91-contrib
service postgresql-9.1 initdb
chkconfig postgresql-9.1 on

# python virtualenv setup
source /opt/rh/python27/enable
virtualenv /usr/local/nav
source /usr/local/nav/bin/activate
export PATH=$PATH:/usr/pgsql-9.1/bin

# Building nav
# 1. sass is needed to compile css
gem install sass --no-rdoc --no-ri

# 2. Download, unpack
cd /tmp
wget -L -c https://launchpad.net/nav/4.1/4.1.1/+download/nav-4.1.1.tar.gz
tar xvfz nav-4.1.1.tar.gz && cd nav-4.1.1

# 3. Remove xmpppy, install python deps into virtualenv
sed -i '/xmpppy/d' requirements.txt
pip install -r requirements.txt

# 4. build and install
./configure
make
make install
cd
# deactivate nav virtualenv
deactivate

# 5. add nav group and user
groupadd --system nav
adduser --system --no-create-home --home-dir /usr/local/nav --gid nav --groups dialout navcron
# nav/var must be writable
chown -R navcron:nav /usr/local/nav/var

# Building graphite
# create graphite virtualenv and activate it
virtualenv /opt/graphite
source /opt/graphite/bin/activate

pip install whisper carbon graphite-web django-tagging

