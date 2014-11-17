default[:tilestache][:pip_requirements_location]      = "#{Chef::Config[:file_cache_path]}/tilestache_pip_requirements.txt"

# default python package versions when using pip_requirements install method
default[:tilestache][:pip_requirements] = %w(
  argparse==1.2.1
  python-memcached==1.53
  ModestMaps==1.4.6
  Pillow==2.6.1
  protobuf==2.6.0
  psycopg2==2.5.4
  Shapely==1.4.3
  simplejson==3.6.4
  git+https://github.com/mapzen/TileStache@integration-1#egg=TileStache
  Werkzeug==0.9.6
  wsgiref==0.1.2
)
