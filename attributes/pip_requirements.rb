default[:tilestache][:pip_requirements_location] = "#{Chef::Config[:file_cache_path]}/tilestache_pip_requirements.txt"

# default python package versions when using pip_requirements install method
default[:tilestache][:pip_requirements][:argparse] = 'argparse==1.2.1'
default[:tilestache][:pip_requirements][:modestmaps] = 'ModestMaps==1.4.6'
default[:tilestache][:pip_requirements][:pillow] = 'Pillow==2.6.1'
default[:tilestache][:pip_requirements][:protobuf] = 'protobuf==2.6.0'
default[:tilestache][:pip_requirements][:psycopg2] = 'psycopg2==2.5.4'
default[:tilestache][:pip_requirements][:shapely] = 'Shapely==1.4.3'
default[:tilestache][:pip_requirements][:simplejson] = 'simplejson==3.6.4'
default[:tilestache][:pip_requirements][:tilestache] = 'git+https://github.com/mapzen/TileStache@integration-1#egg=TileStache'
default[:tilestache][:pip_requirements][:werkzeug] = 'Werkzeug==0.9.6'
default[:tilestache][:pip_requirements][:wsgiref] = 'wsgiref==0.1.2'
