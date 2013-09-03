# == Class: phpmyadmin
#
# === Parameters
#
# [path] The path to install phpmyadmin to (default: /srv/phpmyadmin)
# [user] The user that should own that directory (default: www-data)
# [servers] An array of servers (default: [])
#
# === Examples
#
#  class { 'phpmyadmin':
#    path => "/srv/phpmyadmin",
#    user => "www-data",
#    servers => [
#      {
#        desc => "local",
#        host => "127.0.0.1",
#      },
#      {
#        desc => "other",
#        host => "192.168.1.30",
#      }
#    ]
#  }
#
# === Authors
#
# Arthur Leonard Andersen <leoc.git@gmail.com>
#
# === Copyright
#
# See LICENSE file, Arthur Leonard Andersen (c) 2013

# Class:: phpmyadmin
#
#
class phpmyadmin (
  $path = "/srv/phpmyadmin",
  $user = "www-data",
  $servers = []
) {
  file { $path:
    ensure => "directory",
    owner => $user,
  }

  exec { "phpmyadmin-checkout":
    path => "/bin:/usr/bin",
    creates => "$path/.git",
    command => "git clone https://github.com/phpmyadmin/phpmyadmin.git ${path}",
    require => File[$path],
    user => $user,
  }

  exec { "phpmyadmin-upgrade":
    path => "/bin:/usr/bin",
    command => "bash -c 'cd ${path}; git fetch; git checkout origin/STABLE'",
    require => Exec["phpmyadmin-checkout"],
    user => $user,
  }

  file { "phpmyadmin-conf":
    path => "$path/config.inc.php",
    content => template("phpmyadmin/config.inc.php.erb"),
    owner => $user,
    require => Exec["phpmyadmin-upgrade"],
  }
} # Class:: phpmyadmin
