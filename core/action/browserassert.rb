module AutoEasy
  module Core
    class BrowserAssert
      attr_reader :page_action
      attr_reader :page_assert
      
      def initialize(browser_act, opts={})
        @page_action = browser_act
        @page_assert = AutoEasy::Core::Assert.new(opts)
      end
      
      def assert_url(assertion, value)
        @page_assert.assert("Assert page url.", @page_action.get_url, value, assertion)
      end
      
      def assert_alert_text(assertion, value)
        @page_assert.assert("Assert alert text.", @page_action.alert_text(), value, assertion)
      end
      
    end
  end
end
