# Class: mcollective::server::service
#
#   This class installs and enables the MCollective service.
#
# Parameters:
#
#  [*mc_service_name*]  - The name of the mcollective service
#  [*mc_service_stop*]  - The command used to stop the mcollective service
#  [*mc_service_start*] - The command used to start the mcollective service
#  [*init_pattern*]     - The pattern used for the init service.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mcollective::server::service(
  $mc_service_name     = $mcollective::params::mc_service_name,
  $mc_service_stop     = 'UNSET',
  $mc_service_start    = 'UNSET',
  $init_pattern        = 'UNSET'
) {

  $mc_service_stop_real = $mc_service_stop ? {
    'UNSET' => $mcollective::params::mc_service_stop,
    false   => undef,
    default => $mc_service_stop,
  }
  $mc_service_start_real = $mc_service_start ? {
    'UNSET' => $mcollective::params::mc_service_start,
    false   => undef,
    default => $mc_service_start,
  }

  if $init_pattern != 'UNSET' {
    $hasstatus = undef
    $pattern   = $init_pattern
  } else {
    $hasstatus = true
    $pattern   = undef
  }

  service { 'mcollective':
    ensure    => running,
    name      => $mc_service_name,
    pattern   => $pattern,
    hasstatus => $hasstatus,
    start     => $mc_service_start_real,
    stop      => $mc_service_stop_real,
  }

}
