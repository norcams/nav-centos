class Nav < FPM::Cookery::Recipe

  # Package metadata
  name        'nav'

  description   'Network Administration Visualized'
  homepage      'http://nav.uninett.no'
  maintainer    'code@beddari.net'
  license       'GNU GPL v2'
  section       'Utilities'

  version       '4.2.6'
  revision      '1'
  source        'https://launchpad.net/nav/4.2/4.2.6/+download/nav-4.2.6.tar.gz'
  md5           'ee78c9a8272d4ae097d3c2eddd5af51f'
  config_files  '/usr/local/nav/etc/db.conf', '/usr/local/nav/etc/nav.conf'

  build_depends 'python-virtualenv', 'rubygems', 'git',
                'automake', 'gcc', 'gcc-c++',
                'subversion', 'openldap-devel',
                'postgresql-devel'

  def build
    # remove xmpp support
    # safesystem 'sed -i \'/xmpppy/d\' requirements.txt'

    # fix xmpp
    safesystem 'sed -i "s/\(^xmpppy\).*/\1==0.5.0rc1/" requirements.txt'

    # add additional dep to pynetsnmp
    safesystem 'sed -i "s/\(.*pynetsnmp-.*\)/#\1/" requirements.txt; \
                echo "git+https://github.com/zenoss/pynetsnmp" >> requirements.txt; \
                echo "ipaddr" >> requirements.txt'

    safesystem 'gem install sass --no-ri --no-rdoc'

    safesystem "virtualenv /usr/local/nav"

    safesystem "source /usr/local/nav/bin/activate; \
                pip install -r requirements.txt --allow-external PIP"

    safesystem  "source /usr/local/nav/bin/activate; \
                env PATH=/usr/local/bin:$PATH \
                ./configure"

    safesystem "source /usr/local/nav/bin/activate; \
                env PATH=/usr/local/bin:$PATH \
                make"

    # Add lib/python to the search path/env
    safesystem "echo ../../python > \
                /usr/local/nav/lib/python2.7/site-packages/nav.pth"
  end

  def install
    safesystem "source /usr/local/nav/bin/activate; \
                make install"
  end

end

