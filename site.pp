if versioncmp($::puppetversion,'3.6.1') >= 0 {

  $allow_virtual_packages = hiera('allow_virtual_packages',false)

  Package {
    allow_virtual => $allow_virtual_packages,
  }
}

import 'nodes/www.kwalinux.nl.pp'
import 'nodes/puppet.kwalinux.nl.pp'
