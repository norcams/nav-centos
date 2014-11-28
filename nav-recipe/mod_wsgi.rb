class Nav < FPM::Cookery::Recipe

  # Package metadata
  name        'mod_wsgi'

  description 'An Apache module that implements a WSGI compliant interface for hosting Python 
               based web applications on top of the Apache web server.'
  homepage    'http://nav.uninett.no'
  maintainer  'anders@unix.uib.no'
  license     'Apache License, Version 2.0'
  section     'Libraries'

  version     '4.3.2'
  revision    '1'
  source      'https://github.com/GrahamDumpleton/mod_wsgi/archive/4.3.2.tar.gz'

  build_depends 'python27', 'httpd-devel',
                'automake', 'gcc'

  depends 'python27', 'httpd'

  def build
    safesystem 'source /opt/rh/python27/enable; \
                LD_LIBRARY_PATH=/opt/rh/python27/root/usr/lib64/:/opt/rh/python27/root/usr/lib/:$LD_LIBRARY_PATH \
                ./configure --with-python=/opt/rh/python27/root/usr/bin/python2.7 && \
                sed -i "/^LDFLAGS/ s/$/ \-R\/opt\/rh\/python27\/root\/usr\/lib64/" Makefile && \
                make'
  end

  def install
    safesystem 'sed -i "s/\(LIBEXECDIR\ \=\ \).*/\1\/usr\/local\/nav\/lib64\/httpd\/modules/" Makefile && \
                make install'
  end

end

