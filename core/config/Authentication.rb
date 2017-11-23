# encoding=utf-8
#Author: Stephen Zhang
# Authention definition for rest/soap service call
module AutoEasy
  module Core
    class Authentication
      attr_reader :domain, :username, :password

      def initialize(domain="", username, password)
        @domain, @username, @password = domain, username, password
      end

    end
  end
end
