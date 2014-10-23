class Graphite < FPM::Cookery::Recipe

  # Package metadata
  name        'graphite'

  description 'A Django webapp for enterprise scalable realtime graphing'
  homepage    'https://launchpad.net/graphite/'
  maintainer  'code@beddari.net'
  license     'ASL 2.0'
  section     'Utilities'

  version     '0.9.12'
  revision    '1'
  source      '', :with => :noop

  build_depends 'python27', 'automake', 'gcc', 'gcc-c++'
  depends 'python27'

  def build
    safesystem 'source /opt/rh/python27/enable; virtualenv /opt/graphite'
    safesystem 'source /opt/rh/python27/enable; \
                source /opt/graphite/bin/activate; \
                pip install whisper carbon graphite-web django-tagging'
  end

  def install
    # nothing yet!
  end
end

