require 'capybara/cucumber'
require 'rbconfig'
include RbConfig

require 'selenium-webdriver'
#require 'rspec'
#require 'rspec/expectations'
require 'yaml'
require 'viewpoint'


include Viewpoint::EWS



# Load main configuration
environment = ENV['ENV'] || 'qa1'
puts "Using environment #{environment}"

mainconfig = YAML::load_file('features/support/config.yml')

# Global constants
WMVR_URL = mainconfig.fetch(environment)["wmvr_url"]
#ADMIN_USER = mainconfig.fetch(environment)["admin_user"]
#ADMIN_PASSWORD = mainconfig.fetch(environment)["admin_password"]
TEST_USER = mainconfig.fetch(environment)["test_user"]
TEST_PASSWORD = mainconfig.fetch(environment)["test_password"]

Capybara.register_driver :selenium do |app|
  
  #Capybara::Selenium::Driver.new(app, :browser => :internet_explorer)
   #Capybara::Selenium::Driver.new(app, :browser => :chrome)
   Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

Capybara.default_driver = :selenium                              



