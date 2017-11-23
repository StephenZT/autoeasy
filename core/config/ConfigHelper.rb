# encoding=utf-8
#Author: Stephen Zhang
#Collect all configuration together so that it can set/get configuration easily

require File.expand_path(File.dirname(__FILE__)) + "/Supports.rb"
require File.expand_path(File.dirname(__FILE__)) + "/Config.rb"
require File.expand_path(File.dirname(__FILE__)) + "/DBConfig.rb"


module AutoEasy
  module Core
    module ConfigHelper
      #support conifg
      def self.conifg_enironment(value=[])
        G_Supports.environments = value
      end
      def self.conifg_platforms(value=[])
        G_Supports.platforms = value
      end
      def self.conifg_browsers(value=[])
        G_Supports.browsers = value
      end
      def self.conifg_devices(value=[])
        G_Supports.devices = value
      end
      #Current config
      def self.config_current_stage(env,platform,browser,device,loglevel)
        G_Configuration.setConfig("environment",env)
        G_Configuration.setConfig("platform",platform)
        G_Configuration.setConfig("browser",browser)
        G_Configuration.setConfig("device",device)
        G_Configuration.setConfig("loglevel",loglevel)
      end
      #databaxe config
      def self.config_databases(env,name,configs={})
        G_DBConfig.addConfig(env,name,configs)
      end
      
      #Get current configs
      def self.get_env
        return G_Configuration.getConfig()["environment"]
      end      
      
      def self.get_platform
        return G_Configuration.getConfig()["platform"]
      end
      
      def self.get_browser
        return G_Configuration.getConfig()["browser"]
      end
      
      def self.get_device
        return G_Configuration.getConfig()["device"]
      end
      
      def self.get_loglevel
        return G_Configuration.getConfig()["loglevel"]
      end
      
      def self.get_database(env,name)
        G_DBConfig.getConfig(env,name)
      end
      
      def self.get_default_database()
        get_database(get_env,"default")
      end
      
      def self.config_auth(name, authentication)
        G_AuthRegister.addAuth(name, authentication)
      end
      
      def self.get_auth(name)
        return G_AuthRegister.getAuth(name)
      end
      
    end
  end
end

G_ConfigHelper ||= AutoEasy::Core::ConfigHelper
