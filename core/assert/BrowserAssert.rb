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
        @assert.assert("Assert page url.", @action.get_url.downcase, value.downcase, assertion)
      end
      
      def assert_title(assertion, value)
        @assert.assert("Assert page title.", @action.title.downcase, value.downcase, assertion)
      end
      
      def assert_text_in_page_source(assertion, value)
        @assert.assert("Assert text in page source.", @action.get_page_source(), value.downcase, assertion)
      end
      
      def assert_alert_text(assertion, value)
        @assert.assert("Assert alert text.", @action.alert_text(), value, assertion)
      end
      
      def assert_url_in(value)
        raise "Given urls #{value} is not array" if !value.kind_of?(Array)
        is_url_in = false
        
        value.each do |url|
          if (@action.get_url.downcase.include? url.downcase)
            is_url_in = true
            break
          end
        end
        
        @assert.assert("Assert page url #{@action.get_url()} in #{value}.", true, is_url_in, "==")
      end
    end
  end
end
