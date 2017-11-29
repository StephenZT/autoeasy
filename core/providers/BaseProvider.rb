#encoding=utf-8
#Author: Stephen Zhang
#Base class for all test data provider

module AutoEasy
  module Core
    class BaseProvider
      def initialize(opts={})
        @data = Hash.new  
      end
      #Get test data by given key
      def getData(key)
         return @data[key]
      end
      
      def addDate(key, value)
        @data[key] = value
      end
    end
  end
end
