class NavOmnibus < FPM::Cookery::Recipe
  homepage 'https://nav.uninett.no/doc/latest/intro/install.html'

  section 'Utilities'
  name 'nav-omnibus'
  version '4.2.6'
  description 'NAV omnibus package'
  revision 3
  maintainer '<code@beddari.net>'
  license 'Apache 2.0 License'

  source '', :with => :noop

  omnibus_package true
  omnibus_dir     '/usr/local/nav'
  omnibus_recipes 'nav'

  def build
    # Nothing
  end

  def install
    # Nothing
  end

end

