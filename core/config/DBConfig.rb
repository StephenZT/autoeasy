# encoding=utf-8
#Author: Stephen Zhang
# add database configurations those used in test case
# DBConfig.addConfig("qa3","default", {:database => "dbname",:dataserver => "servername"})
# puts DBConfig.getConfig("qa3","default")

require 'singleton'


module AutoEasy
  module Core
    class DBConfig
      include Singleton
      
      attr_reader :setting
      
      def addConfig(environment, name, config={})
        @setting = Hash.new if @setting == nil
        
        if @setting.key?(environment) then
          raise "Config for #{environment} is not a hash" if !@setting[environment].is_a?(Hash) 
          raise "Config already exists for #{environment}:#{name}" if @setting[environment].key?(name)
          @setting[environment][name] = config
        else
          @setting[environment] = Hash.new
          @setting[environment][name] = config
        end
      end
      
      def getConfig(environment, name)
          raise "Config for #{environment} is not registered." if !@setting.key?(environment)
          raise "Config for #{environment} is not a valid hash format." if !@setting[environment].is_a?(Hash) 
          raise "Config for #{environment}:#{name} is not registered." if !@setting[environment].key?(name)
          return @setting[environment][name]
      end
      
    end
  end
end

G_DBConfig ||= AutoEasy::Core::DBConfig.instance


