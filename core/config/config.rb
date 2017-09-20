require File.expand_path(File.dirname(__FILE__)) + "/Supports.rb"
require 'singleton'

module AutoEasy
  module Core
    class Config
      include Singleton
      #current settings
      attr_accessor :setting
       
      def setEnvironment(env)
        @setting['environment'] = env
      end
      
      def setPlatform(platform)
        @setting['platform'] = platform
      end
      
      def setBrowser(browser)
        @setting['browser'] = browser
      end
      
      def setDevice(device)
        @setting['device'] = device
      end
      
      def setLogLevel(loglevel)
        @setting['loglevel'] = loglevel
      end
      
      def setConfig(key,value)
        @setting[key] = value
      end
      
      def getConfig()
        return @setting
      end
      
      def setDefault()
        #Set default settings
        @setting = Hash.new if @setting == nil
        @setting['environment'] =  AutoEasy::Core::Supports::ENVIRONMENTS[0]
        @setting['platform'] = AutoEasy::Core::Supports::PLATFORMS[0]
        @setting['browser'] = AutoEasy::Core::Supports::BROWSERS[0]
        @setting['device'] = AutoEasy::Core::Supports::DEVICES[0]
        @setting['loglevel'] = AutoEasy::Core::Supports::LOGLEVELS[0]
      end
      
    end
  end
end

Configuration ||= AutoEasy::Core::Config.instance
Configuration.setDefault()

