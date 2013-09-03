# Puppet-phpmyadmin

A puppet module to easily deploy phpmyadmin. Make sure you have a
correct php5 installation. This module only clones the latest
phpmyadmin repository state and creates the correct configuration
file.

You may have to install `php5-fpm` (via puppet-php) and configure your
web server (e.g. puppet-nginx)

## Usage

```
  class { 'phpmyadmin':
    path => "/srv/phpmyadmin",
    user => "www-data",
    servers => [
      {
        desc => "local",
        host => "127.0.0.1",
      },
      {
        desc => "other",
        host => "192.168.1.30",
      }
    ]
  }
```

## Contribute

Want to help - send a pull request.
