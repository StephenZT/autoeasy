require File.expand_path(File.dirname(__FILE__)) + "/Supports.rb"

module AutoEasy
  module Core
    class Config
      #current settings
      attr_reader :setting
      
      def initialize(opt={})
        @setting = Hash.new
        #Set default settings
        @setting['environment'] = AutoEasy::Core::Supports::ENVIRONMENTS[0]
        @setting['platform'] = AutoEasy::Core::Supports::PLATFORMS[0]
        @setting['browser'] = AutoEasy::Core::Supports::BROWSERS[0]
        @setting['device'] = AutoEasy::Core::Supports::DEVICES[0]
        @setting['loglevel'] = AutoEasy::Core::Supports::LOGLEVELS[0]
      end
      
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
      
    end
  end
end
