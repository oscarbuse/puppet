node 'puppet.kwalinux.nl' {
  include accounts
  include ssh

  # named
  class { '::bind': chroot => true }
  include bind
  bind::server::conf { '/var/named/chroot/etc/named.conf':
  listen_on_addr    => [ 'any' ],
  listen_on_v6_addr => [ 'any' ],
  allow_query       => [ 'any' ],
  allow_transfer    => [ '37.97.130.118' ],
  recursion	    => 'no',
  zones             => {
    'kwalinux.nl' => [
      'type master',
      'file "master/kwalinux.nl"',
      'notify yes',
    ],
    'linuversity.nl' => [
      'type master',
      'file "master/linuversity.nl"',
      'notify yes',
    ],
    'linuxcursus.nl' => [
      'type master',
      'file "master/linuxcursus.nl"',
      'notify yes',
    ],
    'linuxnerd.nl' => [
      'type master',
      'file "master/linuxnerd.nl"',
      'notify yes',
    ],
    'osgn.nl' => [
      'type master',
      'file "master/osgn.nl"',
      'notify yes',
    ],
    'reisavonturen.net' => [
      'type master',
      'file "master/reisavonturen.net"',
      'notify yes',
    ],
    'travelstories.net' => [
      'type master',
      'file "master/travelstories.net"',
      'notify yes',
    ],
  },
}
  bind::server::file { [
    'kwalinux.nl', 'linuversity.nl', 'linuxcursus.nl', 'linuxnerd.nl', 'osgn.nl', 'reisavonturen.net', 'travelstories.net',
  ]:
  zonedir => '/var/named/chroot/var/named/master',
  source_base => '/etc/puppet/modules/bind/files/master/',
  }
  # /named

}
