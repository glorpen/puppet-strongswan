class strongswan::package {
  $package_name = $::strongswan::package_name

  package { $package_name:
    ensure => 'present'
  }

  case $::facts['os']['name'] {
    'Centos': {
      ensure_package('epel')

        Package['epel']
        ->Package[$package_name]
    }
    default: {}
  }
}
