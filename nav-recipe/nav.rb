class Nav < FPM::Cookery::Recipe

  # Package metadata
  name        'nav'

  description 'Network Administration Visualized'
  homepage    'http://nav.uninett.no'
  maintainer  'code@beddari.net'
  license     'GNU GPL v2'
  section     'Utilities'

  version     '4.1.1'
  revision    '1'
  source      'https://launchpad.net/nav/4.1/4.1.1/+download/nav-4.1.1.tar.gz'
  sha256      'e269075a30be8d8a4da9546550ed7fa40b76de4ee42b8d34c5db17b1689d228f'

  build_depends 'python27',
                'automake', 'gcc', 'gcc-c++',
                'subversion', 'openldap-devel',
                'postgresql91-devel'

  depends 'python27'

  def build
    safesystem 'sed -i \'/xmpppy/d\' requirements.txt'
    safesystem 'gem install sass --no-ri --no-rdoc'
    safesystem "source /opt/rh/python27/enable; virtualenv /usr/local/nav"
    safesystem "source /opt/rh/python27/enable; \
                source /usr/local/nav/bin/activate; \
                env PATH=$PATH:/usr/pgsql-9.1/bin \
                pip install -r requirements.txt"
    safesystem "source /opt/rh/python27/enable; \
                source /usr/local/nav/bin/activate; \
                ./configure --prefix=/usr/local/nav --sysconfdir=/etc/nav"
    safesystem "source /opt/rh/python27/enable; \
                source /usr/local/nav/bin/activate; \
                make"
  end

  def install
    safesystem "source /opt/rh/python27/enable; \
                source /usr/local/nav/bin/activate; \
                make install"
    etc('nav'). install Dir['nav/*']
  end
end

