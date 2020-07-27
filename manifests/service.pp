class strongswan::service {
  service { $::strongswan::service_name:
    ensure => running,
    enable => true
  }
}
