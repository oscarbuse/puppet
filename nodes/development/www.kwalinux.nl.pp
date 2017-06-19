node 'www.kwalinux.nl' {
  include accounts
  include ssh-oscar

  # apache
  include apache
  include apache::mod::php
  include apache::mod::perl

# mobile sites
# m.kwalinux.nl
  apache::vhost { 'm.kwalinux.nl':
    port    => '80',
    docroot => '/var/www/mobile/kwalinux/web-docs',
  }
# m.viafrica.org
  apache::vhost { 'm.viafrica.org':
    port    => '80',
    docroot => '/var/www/mobile/viafrica/web-docs',
  }
# /mobile sites

# moodle content cwa2
# disabled for now
# courses.kwalinux.nl
#  apache::vhost { 'courses.kwalinux.nl':
#    port    => '80',
#    docroot => '/var/www/cwa2.viafrica.org',
#  }

# TuxiT wordpress / webshop (?)
# disabled for now 
# www.tuxit.nl
  apache::vhost { 'www.tuxit.nl':
    port    => '80',
    docroot => '/var/www/tuxit/web-docs',
    directories => [
	{
            'path' => '/var/www/tuxit/web-docs',
            'options' => 'Indexes FollowSymLinks MultiViews',
            'allow_override' => 'All',
    	},
    ],
  }


# waalkade.all-stars.nl
  apache::vhost { 'waalkade.all-stars.nl':
    port    => '80',
    serveraliases => ['waalkade.all-stars.nl'],
    docroot => '/var/www/waalkade/web-docs',
  }

# wwi.kwalinux.nl
  apache::vhost { 'wwi.kwalinux.nl':
    port    => '80',
    serveraliases => ['wwi.kwalinux.nl'],
    docroot => '/var/www/wwi/web-docs',
    directories => [
        {
            'path' => '/var/www/wwi/web-docs',
            'options' => 'Indexes FollowSymLinks MultiViews',
            'allow_override' => 'All',
        },
    ],
  }

# www.linuxcursus.nl
  apache::vhost { 'www.linuxcursus.nl':
    port    => '80',
    serveraliases => ['linuxcursus.nl'],
    docroot => '/var/www/linuxcursus/web-docs',
  }

# www.linuversity.nl
  apache::vhost { 'www.linuversity.nl':
    port    => '80',
    serveraliases => ['linuversity.nl'],
    docroot => '/var/www/linuversity/web-docs',
  }

# doc.kwalinux.nl
  apache::vhost { 'doc.kwalinux.nl':
    port    => '80',
    docroot => '/var/www/kwalinux/doc/mediawiki',
  }

# cloud.kwalinux.nl
  apache::vhost { 'cloud.kwalinux.nl non-ssl':
    servername => 'cloud.kwalinux.nl',
    port    => '80',
    docroot => '/var/www/cloud/web-docs',
    redirect_status => 'permanent',
    redirect_dest   => 'https://cloud.kwalinux.nl/',
  }
# The SSL virtual host at the same domain
  apache::vhost { 'cloud.kwalinux.nl ssl':
    servername => 'cloud.kwalinux.nl',
    port       => '443',
    docroot    => '/var/www/cloud/web-docs',
    ssl        => true,
    ssl_cert => '/etc/letsencrypt/live/cloud.kwalinux.nl/cert.pem',
    ssl_key => '/etc/letsencrypt/live/cloud.kwalinux.nl/privkey.pem',
    ssl_chain => '/etc/letsencrypt/live/cloud.kwalinux.nl/chain.pem',
    custom_fragment => 'Include /etc/letsencrypt/options-ssl-apache.conf',
  }

# travelstories.net
  apache::vhost { 'www.travelstories.net':
    port    => '80',
    docroot => '/var/www/travelstories/web-docs',
    directories => [
	{
            'path' => '/var/www/travelstories/web-docs',
            'options' => 'Indexes FollowSymLinks MultiViews',
            'allow_override' => 'All',
    	},
    ],
  }

# www.dedesktop.nl
  apache::vhost { 'www.dedesktop.nl':
    port    => '80',
    docroot => '/var/www/www.dedesktop.nl',
    directories => [
        {
            'path' => '/var/www/www.dedesktop.nl',
            'options' => 'Indexes FollowSymLinks MultiViews',
            'allow_override' => 'All',
            #'auth_type' => 'Basic',
            #'auth_name' => 'myrobotaccessonly',
            #'auth_basic_provider' => 'file',
            #'auth_user_file' => '/var/www/.mypasswdfile',
            #'auth_require' => 'user myrobotuser',
        },
    ],
  }

# make /var/www/www.dedesktop.nl van git
  file {
    "/var/www/www.dedesktop.nl":
	ensure => "directory",
	owner => "git",
	group => "git";
  }

# www.kwalinux.nl
apache::vhost { 'www.kwalinux.nl non-ssl':
    servername => 'www.kwalinux.nl',
    serveraliases => 'kwalinux.nl',
    port    => '80',
    docroot => '/var/www/kwalinux/web-docs',
    redirect_status => 'permanent',
    redirect_dest   => 'https://www.kwalinux.nl/',
  }

apache::vhost { 'www.kwalinux.nl ssl':
    servername => 'www.kwalinux.nl',
    port    => '443',
    docroot => '/var/www/kwalinux/web-docs',
    ssl => true,
    ssl_cert => '/etc/letsencrypt/live/www.kwalinux.nl/cert.pem',
    ssl_key => '/etc/letsencrypt/live/www.kwalinux.nl/privkey.pem',
    ssl_chain => '/etc/letsencrypt/live/www.kwalinux.nl/chain.pem',
    custom_fragment => 'Include /etc/letsencrypt/options-ssl-apache.conf',
    directories => [
        {
            'path' => '/var/www/kwalinux/web-docs',
            'options' => '-Indexes',
            'allow_override' => 'All',
        },
        {
            'path' => '/var/www/kwalinux/web-docs/cgi',
            'options' => 'Indexes FollowSymLinks MultiViews ExecCGI Includes',
            'allow_override' => 'All',
	    'custom_fragment' => 'AddType application/x-httpd-cgi .pl',
	    'custom_fragment' => 'AddHandler cgi-script .pl',
        },
        {
            'path' => '/var/www/kwalinux/web-docs/administratie',
            'options' => 'Indexes FollowSymLinks MultiViews ExecCGI Includes',
            'allow_override' => 'All',
	    'custom_fragment' => 'AddType application/x-httpd-cgi .cgi',
	    'custom_fragment' => 'AddHandler cgi-script .cgi',
        },
        {
            'path' => '/var/www/kwalinux/web-docs/view',
            'options' => 'Indexes FollowSymLinks MultiViews ExecCGI Includes',
            'allow_override' => 'All',
            'custom_fragment' => 'AddType application/x-httpd-cgi .cgi',
            'custom_fragment' => 'AddHandler cgi-script .cgi',
        },
    ],
  }

# www.all-stars.nl
apache::vhost { 'www.all-stars.nl':
    port    => '80',
    docroot => '/var/www/all-stars/web-docs',
    directories => [
        {
            'path' => '/var/www/all-stars/web-docs',
            'options' => 'Indexes FollowSymLinks ExecCGI Includes',
            'allow_override' => 'All',
	    'custom_fragment' => 'AddType application/x-httpd-cgi .cgi',
        },
        {
            'path' => '/var/www/all-stars/web-docs/cgi',
            'options' => 'Indexes FollowSymLinks ExecCGI Includes',
            'allow_override' => 'All',
	    'custom_fragment' => 'AddType application/x-httpd-cgi .pl',
        },
    ],
    scriptaliases => [
        {
            alias => '/star-bin/',
            path => '/var/www/all-stars/star-bin/',
        },
    ],
  }

# merle.all-stars.nl
# disabled for now (movies copyrighted...)
#apache::vhost { 'merle.all-stars.nl':
#    port    => '80',
#    docroot => '/var/www/merle/web-docs',
#    directories => [
#        {
#            'path' => '/var/www/merle/web-docs',
#            'options' => 'Indexes FollowSymLinks ExecCGI Includes',
#            'allow_override' => 'All',
#            'custom_fragment' => 'AddType application/x-httpd-cgi .cgi',
#        },
#    ],
#  }


# www.reisavonturen.net
# see /etc/httpd/nopuppet
apache::vhost { 'www.reisavonturen.net non-ssl':
    servername => 'www.reisavonturen.net',
    serveraliases => 'reisavonturen.net',
    port    => '80',
    docroot => '/var/www/reisavonturen/web-docs',
    redirect_status => 'permanent',
    redirect_dest   => 'https://www.reisavonturen.net/',
  }

apache::vhost { 'www.reisavonturen.net ssl':
    servername => 'www.reisavonturen.net',
    port    => '443',
    docroot => '/var/www/reisavonturen/web-docs',
    ssl => true,
    ssl_cert => '/etc/letsencrypt/live/www.reisavonturen.net/cert.pem',
    ssl_key => '/etc/letsencrypt/live/www.reisavonturen.net/privkey.pem',
    ssl_chain => '/etc/letsencrypt/live/www.reisavonturen.net/chain.pem',
    custom_fragment => 'Include /etc/letsencrypt/options-ssl-apache.conf',
    directories => [
        {
            'path' => '/var/www/reisavonturen/web-docs',
            'options' => 'Indexes FollowSymLinks ExecCGI Includes',
            'allow_override' => 'All',
            'custom_fragment' => 'AddType application/x-httpd-cgi .cgi',
        },
        {
            'path' => '/var/www/reisavonturen/web-docs/cgi',
            'options' => 'ExecCGI',
            'allow_override' => 'All',
            'custom_fragment' => 'SetHandler perl-script',
            'custom_fragment' => 'PerlResponseHandler ModPerl::Registry',
        },
        {
            'path' => '/var/www/reisavonturen/web-docs/zoek',
            'options' => 'Indexes FollowSymLinks ExecCGI Includes',
            'allow_override' => 'All',
            # RewriteRule ^(.*)$ http://127.0.0.1:9200/$1 [P]
	    rewrites => [ { rewrite_rule => ['^(.*)$ http://127.0.0.1:9200/$1 [P]'] } ]
        },
    ],
    aliases => [
        {
            alias => '/css',
            path => '/var/www/reisavonturen/css',
        },
    ],
    scriptaliases => [
        {
             alias => '/cgi-bin/',
            path => '/var/www/reisavonturen/cgi-bin/',
        },
    ],
    proxy_pass => [
      { 'path' => '/undef', 'url' => 'http://www.reisavonturen.net/cgi-bin/404.cgi' },
    ],
  }


## gallery.reisavonturen.net
## see /etc/httpd/nopuppet
#apache::vhost { 'gallery.reisavonturen.net':
#   port    => '80',
#    docroot => '/var/www/reisavonturen/web-docs/fotogallery',
#    directories => [
#        {
#            'path' => '/var/www/reisavonturen/web-docs/fotogallery',
#            'options' => 'Indexes FollowSymLinks',
#            'allow_override' => 'All',
#  	}
#    ],
#  }

# /apache

# named
  class { '::bind': chroot => true }
  include bind
  bind::server::conf { '/var/named/chroot/etc/named.conf':
  listen_on_addr    => [ 'any' ],
  listen_on_v6_addr => [ 'any' ],
  allow_query       => [ 'any' ],
  allow_transfer    => [ 'localhost' ],
  recursion	    => 'no',
  zones             => {
    'kwalinux.nl' => [
      'type slave',
      'file "slaves/kwalinux.nl"',
      'masters {37.97.130.46;}',
    ],
    'linuversity.nl' => [
      'type slave',
      'file "slaves/linuversity.nl"',
      'masters {37.97.130.46;}',
    ],
    'linuxcursus.nl' => [
      'type slave',
      'file "slaves/linuxcursus.nl"',
      'masters {37.97.130.46;}',
    ],
    'linuxnerd.nl' => [
      'type slave',
      'file "slaves/linuxnerd.nl"',
      'masters {37.97.130.46;}',
    ],
    'osgn.nl' => [
      'type slave',
      'file "slaves/osgn.nl"',
      'masters {37.97.130.46;}',
    ],
    'reisavonturen.net' => [
      'type slave',
      'file "slaves/reisavonturen.net"',
      'masters {37.97.130.46;}',
    ],
    'travelstories.net' => [
      'type slave',
      'file "slaves/travelstories.net"',
      'masters {37.97.130.46;}',
    ],
  },
  }
#  bind::server::file { [
#    'kwalinux.nl', 'linuversity.nl', 'linuxcursus.nl', 'linuxnerd.nl', 'osgn.nl', 'reisavonturen.net', 'travelstories.net',
#  ]:
#  zonedir => '/var/named/chroot/var/named/slaves',
#
# /named
}
