# encoding=utf-8
#Author: Stephen Zhang
require 'securerandom'
require 'selenium-webdriver'
require 'capybara'
require 'fileutils'

module AutoEasy
  module Core
    module DriverRegister
      @registered_drivers = Hash.new
      
      def self.registerDriver(name,opts={})
        if not @registered_drivers.key?(name) then
          @registered_drivers[name] = opts
        else
          raise "Driver name: #{name} already registered."
        end
      end
      
      def self.isRegistered(name)
        return @registered_drivers.key?(name) 
      end
      
      
      def self.instance(name)
        if not @registered_drivers.key?(name) then
          raise "Driver name: #{name} not registered."
        else
          return Capybara::Selenium::Driver.new("autoeasy", @registered_drivers[name])
        end
      end
      
      def self.defaultRegister()
        ##Register chrome
        @client = Selenium::WebDriver::Remote::Http::Default.new
        @client.read_timeout = 120
        @client.open_timeout = 120
        
        chrome_option = Selenium::WebDriver::Chrome::Options.new()
        # profile_path = ""
        # server_whitelist ="*"  #*xxx.zzz.com,*xxx.zzz.com
        # negotiate_delegatewhitelist ="" #xxx.zzz.com,xxx.zzz.com
        chrome_option.add_argument("-disable-popup-blocking")
        # chrome_option.add_argument("user-data-dir=#{profile_path}")
        # chrome_option.add_argument("--auth-server-whitelist=\"#{server_whitelist}\"")
        # chrome_option.add_argument("--auth-negotiate-delegatewhitelist=\"#{negotiate_delegatewhitelist}\"")
        # chrome_option.add_argument("-auth-schemes=\"digest,ntlm,negotiate\"")
        
        registerDriver("chrome", {:browser => :chrome,:http_client=>@client } )

        ##Register IE
        registerDriver("ie", {:browser => :internet_explorer, :http_client => @client, :desired_capabilities => { "ie.ensureCleanSession" => true}})

        ##Register Firefox
        # profile = Selenium::WebDriver::Firefox::Profile.new("c:/xxx/fxprofile")
        # profile["network.automatic-ntlm-auth.trusted-uris"] = "xyz.nextestate.com" #bypass firewall proxy login PD: QA-948
        # profile["geo.enabled"] = true
        # profile["geo.prompt.testing"] = true
        # profile["geo.prompt.testing.allow"] = true;
        # profile["geo.wifi.uri"] = "file://.../geoLocation.json";
        #registerDriver("ie","firefox", {:browser => :firefox, :http_client => @client, :profile => profile, :desired_capabilities => caps})
        caps_fx = Selenium::WebDriver::Remote::Capabilities.firefox marionette: false, acceptInsecureCerts: true;
        registerDriver("firefox", {:browser => :firefox, :http_client => @client, :desired_capabilities => caps_fx})
        
        ##Register marionette
        caps_mt = Selenium::WebDriver::Remote::Capabilities.firefox marionette: true, acceptInsecureCerts: true;
        registerDriver("marionette", {:browser => :firefox, :http_client => @client, :desired_capabilities => caps_mt})

        ##Register marionette
        registerDriver("remote_marionette", {:browser => :remote, :http_client => @client, :url=>"http://localhost:4444/wd/hub", :desired_capabilities => caps_mt})

        ##Register mobile with appium
        # caps_android = {
          # 'appPackage' => 'com.android.calculator2',
          # 'appActivity' => '.Calculator',
          # 'appPackage' => 'com.gobank',
          # 'appActivity' => '.activity.RootActivity',
          # 'platformName' => 'Android',
          # 'deviceName' => 'Ignored',
          # }        
        # registerDriver("android_xyzapp", {:browser => :remote, :url=>"http://localhost:4273/wd/hub", :desired_capabilities => caps_android})
      end
      
    end
  end
end

DriverRegister ||= AutoEasy::Core::DriverRegister
DriverRegister.defaultRegister()

