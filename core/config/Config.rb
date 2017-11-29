# encoding=utf-8
#Author: Stephen Zhang
# Current execution context, test case will be executed under this configuration

require File.expand_path(File.dirname(__FILE__)) + "/Supports.rb"
require 'singleton'

module AutoEasy
  module Core
    class Config
      include Singleton
      #current settings
      attr_accessor :setting
      
      def initialize()
        @setting = Hash.new if @setting == nil
        @setting['environment'] =  G_Supports.environments[0]
        @setting['platform'] = G_Supports.platforms[0]
        @setting['browser'] = G_Supports.browsers[0]
        @setting['device'] = G_Supports.devices[0]
        @setting['loglevel'] = G_Supports.loglevels[0]
        
        #turn on/off ignore cucumber step switch, it might skip steps if meet certain condition
        @setting['skip_step'] = false
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
      
      def setSkipStep(isSkip)
        @setting['skip_step'] = isSkip
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
      
      def getSkipStep()
        return @setting['skip_step']
      end
      
      
      def setConfig(key,value)
        @setting[key] = value
      end
      
      def getConfig()
        return @setting
      end
      
    end
  end
end

G_Configuration ||= AutoEasy::Core::Config.instance

