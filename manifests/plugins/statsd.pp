# == Class: telegraf::plugins::statsd
#
# this plugin adds the Statsd plugin to telegraf
#
# === Parameters
#
#
# === Examples
#
#  include telegraf::plugins::statsd
#
# === Authors
#
# Stephen Herd <sharkannon@gmail.com>
#
class telegraf::plugins::statsd (
  # [statsd] section of telegraf.conf
  $service_address  = ':8125',
  $delete_gauges    = 'false',
  $delete_counters  = 'false',
  $delete_sets      = 'false',
  $delete_timings   = 'true',
  $convert_names    = 'true',
  $allowed_pending_messages = '10000',
  $percentile_limit         = '1000',
  $udp_packet_size          = '1500'
){

  file { "${::telegraf::config_directory}/41-statsd.conf":
    ensure  => file,
    content => template('telegraf/plugins/41-statsd.conf.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'telegraf',
    notify  => Service['telegraf'];
  }
}
