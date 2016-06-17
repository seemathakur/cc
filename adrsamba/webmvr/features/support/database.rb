require 'rubygems'
require 'active_record'
require 'yaml'
require 'composite_primary_keys'


require 'qadb/webmvrdb'
require 'qadb/cesiumdb'

include  Qadb::WebmvrDb
include  Qadb::CesiumDb

environment = ENV['ENV'] || 'qa1'

dbconfig = YAML::load_file('features/support/database.yml')

#CUSTOMER_DB_CONF = dbconfig["customerdb"][environment]
WEBMVR_DB_CONF = dbconfig["webmvrdb"][environment]
WebmvrDatabase.establish_connection WEBMVR_DB_CONF
puts "DATABASE CONNECTION INFO:"
puts WebmvrDatabase.connection_config

CESIUM_DB_CONF = dbconfig["cesiumdb"][environment]
CesiumDatabase.establish_connection CESIUM_DB_CONF
puts CesiumDatabase.connection_config