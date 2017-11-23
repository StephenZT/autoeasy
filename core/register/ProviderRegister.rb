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
        @providers[name.downcase] = provider
      end

      def getProvider(name)
        value = @providers[name]
        return value if value != nil
      end
      
    end
  end
end

G_ProviderRegister = AutoEasy::Core::ProviderRegister.instance
