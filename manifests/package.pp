class strongswan::package {
  $package_name = $::strongswan::package_name

  package { $package_name:
    ensure => 'present'
  }

  case $::facts['os']['name'] {
    'Centos': {
      ensure_packages(['epel-release'])

      Package['epel-release']
      ->Package[$package_name]
    }
    default: {}
  }
}
