class Nav < FPM::Cookery::Recipe

  # Package metadata
  name        'nav'

  description 'Network Administration Visualized'
  homepage    'http://nav.uninett.no'
  maintainer  'code@beddari.net'
  license     'GNU GPL v2'
  section     'Utilities'

  version     '4.1.2'
  revision    '1'
  source      'https://launchpad.net/nav/4.1/4.1.2/+download/nav-4.1.2.tar.gz'
  sha256      '066133f78b250dfe9834a992e4a0f646fd78594eeb944dd17165e5ed4c2df561'

  build_depends 'python27', 'rubygems',
                'automake', 'gcc', 'gcc-c++',
                'subversion', 'openldap-devel',
                'postgresql91-devel'

  depends 'python27'

  def build
    # remove xmpp support
    # safesystem 'sed -i \'/xmpppy/d\' requirements.txt'

    # fix xmpp
    safesystem 'sed -i "s/\(^xmpppy\).*/\1==0.5.0rc1/" requirements.txt'

    # use pysnmp-se instead
    safesystem 'sed -i "s/\(.*pynetsnmp-.*\)/#\1/" requirements.txt; \
                sed -i "s/^#\(.*pysnmp-se.*\)/\1/" requirements.txt'

    safesystem 'gem install sass --no-ri --no-rdoc --version "3.3.9"'

    safesystem "source /opt/rh/python27/enable; \
                virtualenv /usr/local/nav"

    safesystem "source /opt/rh/python27/enable; \
                source /usr/local/nav/bin/activate; \
                env PATH=$PATH:/usr/pgsql-9.1/bin \
                pip install -r requirements.txt"

    safesystem "source /opt/rh/python27/enable; \
                source /usr/local/nav/bin/activate; \
                ./configure"

    safesystem "source /opt/rh/python27/enable; \
                source /usr/local/nav/bin/activate; \
                make"

    # Add lib/python to the search path/env
    safesystem "echo ../../python > \
                /usr/local/nav/lib/python2.7/site-packages/nav.pth"
  end

  def install
    safesystem "source /opt/rh/python27/enable; \
                source /usr/local/nav/bin/activate; \
                make install"
  end

end

