# encoding=utf-8
#Author: Stephen Zhang
#Store all authentications that can be used in rest/soap etc.
module AutoEasy
  module Core
    class AuthRegister
      include Singleton
      @auth = Hash.new

      def addAuth(name, authentication)
        @auth[name.downcase] = authentication
      end

      def getAuth(name)
        value = @auth[name]
        return value if value != nil
      end
      
    end
  end
end

G_AuthRegister = AutoEasy::Core::AuthRegister.instance
