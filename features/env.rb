require File.expand_path(File.dirname(__FILE__)) + "/../Packages.rb"

G_ConfigHelper.conifg_enironment(["QA3","QA4"])
G_ConfigHelper.config_databases("QA3","defualt",{:dataserver=>'servername',:database=>'dbname'})
G_ConfigHelper.config_databases("QA4","defualt",{:dataserver=>'servername',:database=>'dbname'})

G_ConfigHelper.config_current_stage("QA3","desktop","chrome","Windows","Error")

G_DriverFactory.getDriver(G_ConfigHelper.get_browser())

Before do |scenario|
  platform = G_ConfigHelper.get_platform()
  puts "Start scenario " + scenario.name + " on platform: " + platform
end

Before do |step|
end

After do |scenario|
  puts "After scenario"
  # if (scenario.failed?) then
    # page.save_screenshot(scenario.name + "_Scenario_Failed.png")
    # page.save_page(scenario.name + ".html")
  # end
end

After do
  puts engine: Selenium::WebDriver::Platform.engine,
    os: Selenium::WebDriver::Platform.os,
    ruby_version: Selenium::WebDriver::Platform.ruby_version,
    jruby?: Selenium::WebDriver::Platform.jruby?,
    windows?: Selenium::WebDriver::Platform.windows?,
    home: Selenium::WebDriver::Platform.home,
    bitsize: Selenium::WebDriver::Platform.bitsize,
    localhost: Selenium::WebDriver::Platform.localhost,
    ip: Selenium::WebDriver::Platform.ip,
    hostname: `hostname`.strip 
end

at_exit() do
  puts "Remove temp folder and clean test data"
end
