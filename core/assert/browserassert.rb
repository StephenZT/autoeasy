# encoding=utf-8
#Author: Stephen Zhang

module AutoEasy
  module Core
    class BrowserAssert
      attr_reader :action
      attr_reader :assert
      
      def initialize(browser_act, opts={})
        @action = browser_act
        @assert = AutoEasy::Core::Assert.new(opts)
      end
      
      def assert_url(assertion, value)
        @assert.assert("Assert page url.", @action.get_url, value, assertion)
      end
      
      def assert_alert_text(assertion, value)
        @assert.assert("Assert alert text.", @action.alert_text(), value, assertion)
      end
      
    end
  end
end
