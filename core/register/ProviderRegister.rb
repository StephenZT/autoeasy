# encoding=utf-8
#Author: Stephen Zhang

module AutoEasy
  module Core
    module ProviderRegister
      @providers = Hash.new
      
      def self.addProvider(name, provider)
        @providers[name.downcase] = provider
      end

      def self.getProvider(name)
        value = @providers[name]
        return value if value != nil
      end
      
    end
  end
end

G_ProviderRegister = AutoEasy::Core::ProviderRegister
