class Python27 < FPM::Cookery::Recipe
  homepage 'https://nav.uninett.no/doc/latest/intro/install.html'

  section 'Utilities'
  name 'repo-enabler'
  version '1'
  description 'Enabling needed software repositories for NAV'
  revision 1
  maintainer '<code@beddari.net>'
  license 'Apache 2.0 License'

  source '', :with => :noop

  build_depends 'epel-release'

  def build
#    safesystem 'yum -y install http://yum.postgresql.org/9.1/redhat/rhel-6-x86_64/pgdg-redhat91-9.1-5.noarch.rpm || exit 0'
#    safesystem 'yum -y install https://www.softwarecollections.org/en/scls/rhscl/python27/epel-6-x86_64/download/rhscl-python27-epel-6-x86_64.noarch.rpm || exit 0'
  end

  def install
    # Nothing
  end

end

