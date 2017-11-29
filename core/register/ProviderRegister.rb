# encoding=utf-8
#Author: Stephen Zhang

module AutoEasy
  module Core
    class ProviderRegister
      include Singleton
      
      def initialize()
        @providers = Hash.new  
      end
 
      def addProvider(name, provider)
        raise "Page name: #{name} already registered." if @providers.key?(name.downcase)
        @providers[name.downcase] = provider
      end

      def getProvider(name)
        return @providers[name.downcase]
      end
      
      
      def instanceProvider(name)
        if @providers.key?(name.downcase)
          if @providers[name.downcase].is_a?(Hash) then
            pageObj = Object::const_get('AutoEasy::Core::BaseProvider').new(@providers[name.downcase])
            return pageObj
          else
            pageObj = Object::const_get(@providers[name.downcase]).new()
            return pageObj  
          end
        else
          raise "Provider #{name} not registered" 
        end
      end
      
      def isRegistered(name)
        return @providers.key?(name.downcase) 
      end
      
    end
  end
end

G_ProviderRegister = AutoEasy::Core::ProviderRegister.instance
