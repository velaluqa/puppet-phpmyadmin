# == Class: phpmyadmin
#
# === Parameters
#
# [path] The path to install phpmyadmin to (default: /srv/phpmyadmin).
# [user] The user that should own that directory (default: www-data).
# [revision] The revision  (default: origin/STABLE).
# [servers] An array of servers (default: []).
# [depth] The depth for cloning the repository with (default: 0).
#
# === Examples
#
#  class { 'phpmyadmin':
#    path     => "/srv/phpmyadmin",
#    user     => "www-data",
#    revision => "RELEASE_4_0_9",
#    servers  => [
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
  $path     = '/srv/phpmyadmin',
  $user     = 'www-data',
  $revision = 'origin/STABLE',
  $servers  = [],
  $depth    = 0,
) {
  vcsrepo { $path:
    ensure   => present,
    provider => 'git',
    source   => 'https://github.com/phpmyadmin/phpmyadmin.git',
    user     => $user,
    revision => $revision,
    depth    => $depth,
  }
  ->
  file { 'phpmyadmin-conf':
    path    => "${path}/config.inc.php",
    content => template('phpmyadmin/config.inc.php.erb'),
    owner   => $user,
  }
} # Class:: phpmyadmin
