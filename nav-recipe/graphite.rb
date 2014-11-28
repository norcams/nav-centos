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

  build_depends 'python', 'python-virtualenv', 'automake', 'gcc', 'gcc-c++'
  depends 'python', 'pycairo'

  def build
    safesystem 'virtualenv /opt/graphite'
    safesystem 'source /opt/graphite/bin/activate; \
                pip install whisper twisted django==1.4.16 carbon graphite-web django-tagging'
  end

  def install
    # nothing yet!
  end
end

