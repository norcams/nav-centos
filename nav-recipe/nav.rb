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

  build_depends 'python27', 'postgresql91-devel', 'automake', 'gcc', 'gcc-c++', 'subversion', 'openldap-devel'
  depends 'python27'

  def build
    safesystem 'sed -i \'/xmpppy/d\' requirements.txt'
    safesystem "source /opt/rh/python27/enable; virtualenv #{destdir}"
    safesystem "source /opt/rh/python27/enable; source #{destdir}/bin/activate; pip install -r requirements.txt"
  end

  def install
    # nothing yet!
  end
end

