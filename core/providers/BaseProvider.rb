#encoding=utf-8
#Author: Stephen Zhang
#Base class for all test data provider

module AutoEasy
  module Core
    class BaseProvider
      def getData(opt={})
        raise StandardError.new('Unimplemented Error')
      end
    end
  end
end
