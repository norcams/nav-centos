#!/bin/sh

/usr/local/bin/fpm-cook clean
rm -rfv {/vagrant/pkg,/vagrant/cache}
rm -rfv {/usr/local/nav,/opt/graphite}
