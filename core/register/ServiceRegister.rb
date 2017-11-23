# encoding=utf-8
#Author: Stephen Zhang
#Register query script that can be used in whole project
#Examples

module AutoEasy
  module Core
    class ServiceRegister
      include Singleton
      
      def initialize()
        @registered_services = Hash.new  
      end
      
      def registerService(name, request)
        raise "Service name #{name} already exist, please register it with another name." if @registered_services.key?(name)
        @registered_services[name] = request
      end
      
      def getService(name)
        raise "Service name #{name} does not registered." if !@registered_services.key?(name)
        return @registered_services[name] 
      end
    end
  end
end

G_ServiceRegister ||= AutoEasy::Core::ServiceRegister.instance
    
