name             'tilestache'
maintainer       'mapzen'
maintainer_email 'grant@mapzen.com'
license          'All rights reserved'
description      'Installs/Configures tilestache'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.6.8'

recipe 'tilestache', 'Installs tilestache'

%w{ apt git gunicorn python ulimit user apache2 }.each do |dep|
  depends dep
end

%w{ ubuntu }.each do |os|
  supports os
end
