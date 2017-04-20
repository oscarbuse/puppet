if versioncmp($::puppetversion,'3.6.1') >= 0 {

  $allow_virtual_packages = hiera('allow_virtual_packages',false)

  Package {
    allow_virtual => $allow_virtual_packages,
  }
}

if ($environment == "development") {
  import 'nodes/development/www.kwalinux.nl.pp'
} else {
  import 'nodes/production/puppet.kwalinux.nl.pp'
}
