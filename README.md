# Puppet-phpmyadmin

A puppet module to easily deploy phpmyadmin. Make sure you have a
correct php5 installation. This module only clones the latest
phpmyadmin repository state and creates the correct configuration
file.

You may have to install `php5-fpm` (via puppet-php) and configure your
web server (e.g. puppet-nginx)

## Suggested Preparation

This module is as simple as possible. You should be able to choose
your own php installation. This is my own, which works quite fine, as
I find:

1. First I install the
   [nodes/php](https://forge.puppetlabs.com/nodes/php) module.

```
puppet module install nodes/php
```

2. Using this module I install the necessary php packages. For serving
   php I use php-fpm with nginx.

```
class { 'php::extension::mysql': }
class { 'php::extension::mcrypt': }
class { 'php::fpm::daemon':
  ensure => running
}
```

3. Then I install phpmyadmin. See [[Usage]].

4. To install and configure nginx I use the
   [puppetlabs/nginx](https://forge.puppetlabs.com/puppetlabs/nginx) module.

```
puppet module install puppetlabs/nginx
```

5. At last you may set up your vhost. This is depending on the server
   module you are using.

## Usage

```
  class { 'phpmyadmin':
    path     => "/srv/phpmyadmin",
    user     => "www-data",
    revision => "RELEASE_4_0_9",
    servers  => [
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
