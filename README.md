Tilestache Chef Cookbook
===================
![Build Status](https://circleci.com/gh/mapzen/chef-tilestache.png?circle-token=fcbc5361e3bc88c354ebbbe4b4f8021eaf25b723)

Description
-----------
Installs tilestache running under gunicorn, provides a vagrant environment for iterative testing
* website: https://github.com/mapzen/chef-tilestache.git

Usage
-----
    include_recipe 'tilestache'

It's recommended that you use a wrapper cookbook with tilestache. The setup
is very simple: a single recipe that does an ```include_recipe tilestache```,
and provides a template to be placed in ```default[:tilestache][:cfg_path]```.

Supported Platforms
-------------------
Tested on Ubuntu12.04LTS. You can probably get away with distributions similar to those, but as yet
they have not been tested.

Requirements
------------
* Chef >= 11.4
* Vagrant 2

Attributes
----------
### tilestache

#### apache_proxy
Configures Apaache on :80 as a reverse proxy
* default: true

#### filehandle_limit
Ulimit setting for open files permitted to the user configured to run tilestache (default: 20480)

#### install_path
Base location that will house conf/tilecache.cfg
* default: /opt/tilestache

#### user
User to run tilestache as
* default: tilestache

#### uid
Numeric ID for tilestache user
* default: nil

#### gid
Numeric ID for tilestache group
* default: nil

#### user_shell
Shell for your tilestache user
* default: /bin/false

#### user_keygen
Whether to generate ssh keys for your tilestache user
* default: false

#### group
Group to run tilestache as
* default: tilestache

### tilestache.gunicorn

#### version
Version of gunicorn to install
* default: 17.5

#### backlog
Number of pending requests to allow to queue
* default: 100

#### keepalive
Keepalive request timeout
* default: 60

#### max_requests
Max number of requests a worker will serve before restarting
* default: 100

#### piddir
Location of the gunicorn pid file
* default: /var/run/tilestache/gunicorn.pid

#### logdir
Location of the gunicorn log directory
* default: /var/log/tilestache

#### logfile
Name of the gunicorn log file
* default: gunicorn.log

#### port
Port to listen on
* default: 8000

#### timeout
Request timeout interval
* default: 300

#### worker_class
Gunicorn worker class
* default: tornado 
* NOTE: not tested with any other classes

#### preload
Preload application code before forking new processes
* default: false

#### workers
Number of workers to spawn
* default: node.cpu.total

### tilestache.apache

#### server_name
Apache server name
* default: tilestache

#### proxy_port
Apache listen port for the proxy
* default: 8000

#### max
Max connection limit
* default: 20

#### ttl
TTL for idle connections in seconds
* default: 300

#### retrytimeout
The proxy will attempt to reconnect to the gunicorn backend,
this is the retry timeout for those attempts in seconds
* default: 3

#### connectiontimeout
The timeout on apache trying to connect to the gunicorn backend
in seconds.
* default: 3

Dependencies
-----------
* gunicorn, python, ulimit, user

Vagrant Environment
===================

Installation
------------
    vagrant plugin install vagrant-berkshelf 
    bundle install
    berks install
    vagrant up
    vagrant ssh

#### What did that just do?
* installed berkshelf, installed our cookbook dependencies, and booted a virtualbox machine
* access the running tilestache instance: via http://localhost:8000 (gunicorn directly), or http://localhost:8080 (apache)

#### I don't like Vagrant
* well then sir, provision an Ubuntu12.04 LTS system with the provider of your choice, and then bootstrap with chef-solo:
    `knife solo bootstrap root@${host} -r 'recipe[tilestache]'`
* and re-cook with the following:
    `knife solo cook root@${host} -r 'recipe[tilestache]'`
* alternatively, you can add the tilestache cookbook to your chef server and wrap it as you see fit

Provisos
--------
* only been tested on my laptop!!! (just kidding... mostly)
* for realz, only been tested on Ubuntu12.04LTS

Contributing
------------
Fork, create a feature branch, send a pull! Weeee...

License and Authors
-------------------
License: GPL
Authors: grant@mapzen.com
