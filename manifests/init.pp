# == Class: telegraf
#
# Install the InfluxDBs telegraf
#
# === Parameters
#
# [*ensure*]
#  handle installation, activation or purging of telegraf
#
# [*version*]
#  handle version of telegraf
#
# [*install_method*]
#  Set to 'package' to install Telegraf using .deb or .rpm package.
#  Set to 'repository' to install Telegraf using an apt or yum repository.
#  Set to 'local' to use own package infrastructure (like aptly).
#  Defaults to 'package'.
#
# [*install_from_repository *]
#  Install telegraf from official repository
#
#  DEPRICATED COMPATIBILTY MODE for 0.2.0 API of this puppet-module, use
#  install_method instead!
#  Option will be REMOVED when Telegraf 0.3.0 is released
#
# [*config_base_file*]
#  path to the base configuration file
#
# [*config_directory *]
#  path to the configuration directory (snippets)
#
# [*outputs_influxdb_enabled*]
#  Activate InfluxDB as a output Plugin
#
# [*outputs_influxdb_urls*]
#  URLs to output sinks InfluxDB
#
# [*outputs_influxdb_database*]
#  Database name of output sink InfluxDB
#
# [*outputs_influxdb_username*]
#  Username of output sink InfluxDB
#
# [*outputs_influxdb_password*]
#  Password of output sink InfluxDB
#
# [*tags*]
#  Tags given as a key / value pair slice
#
# [*agent_hostname*]
#  Configures agent hostname for sending it to the sinks
#
class telegraf (
  $ensure                    = 'installed',
  $version                   = '0.2.4',
  $install_method            = 'package',
  $install_from_repository   = true,
  $config_base_file          = '/etc/opt/telegraf/telegraf.conf',
  $config_directory          = '/etc/opt/telegraf/telegraf.d',

  # [outputs.influxdb] section of telegraf.conf
  $outputs_influxdb_enabled  = true,
  $outputs_influxdb_urls     = ['http://localhost:8086'],
  $outputs_influxdb_database = 'telegraf',
  $outputs_influxdb_username = 'telegraf',
  $outputs_influxdb_password = 'metricsmetricsmetricsmetrics',

  # [tags] section of telegraf.conf
  $tags                      = undef,

  # [agent]
  $agent_hostname            = $::hostname,
)
{
  class { 'telegraf::install': }
  ->
  class { 'telegraf::config': }
  ~>
  class { 'telegraf::service': }
  ->
  Class['telegraf']
}
