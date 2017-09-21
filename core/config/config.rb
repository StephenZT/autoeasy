# encoding=utf-8
#Author: Stephen Zhang
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
      
      def getEnvironment()
        return @setting['environment'] 
      end
      
      def getPlatform()
        return @setting['platform'] 
      end
      
      def getBrowser()
        return @setting['browser'] 
      end
      
      def getDevice()
        return @setting['device'] 
      end
      
      def getLogLevel()
        return @setting['loglevel']
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
        @setting['environment'] =  GSupports.environments[0]
        @setting['platform'] = GSupports.platforms[0]
        @setting['browser'] = GSupports.browsers[0]
        @setting['device'] = GSupports.devices[0]
        @setting['loglevel'] = GSupports.loglevels[0]
      end
      
    end
  end
end

Configuration ||= AutoEasy::Core::Config.instance
Configuration.setDefault()

