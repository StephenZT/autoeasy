# encoding=utf-8
# Author: Stephen Zhang
# 

module AutoEasy
  module Core
    class ElementAssert
      #Store ElementAction     
      attr_reader :action
      attr_reader :assert
      
      def initialize(element_act, opts={})
        @action = element_act
        @assert = AutoEasy::Core::Assert.new(opts)
      end
    
      def assert_valid()
        @assert.assert("Assert element [#{@action.org_element.name}] is valid.", @action.is_valid(), true, "==")
      end
      
      def assert_invalid()
        @assert.assert("Assert element [#{@action.org_element.name}] is invalid.", @action.is_valid(), false, "==")
      end
      
      def assert_text(assertion, value)
        @assert.assert("Assert element [#{@action.org_element.name}] text.", @action.get_text(), value, assertion)
      end
      
      def assert_value(assertion, value)
        @assert.assert("Assert element [#{@action.org_element.name}] value.", @action.get_value(), value, assertion)
      end
      
      def assert_selected_text(assertion, value)
        @assert.assert("Assert element [#{@action.org_element.name}] selected text.", @action.get_selected_text(), value, assertion)
      end
      
      def assert_tag(assertion, value)
        @assert.assert("Assert element element [#{@action.org_element.name}] tag name.", @action.get_tag_name(), value, assertion)
      end
      
      def assert_option_involved(value)
        @assert.assert("Assert element [#{@action.org_element.name}] option [#{value}] involved.", @action.get_options_text().include?(value), true, "==")
      end
      
      def assert_option_not_involved(value)
        @assert.assert("Assert element [#{@action.org_element.name}] option [#{value}] not involved.", @action.get_options_text().include?(value), false, "==")
      end 
      
      def assert_disabled()
        @assert.assert("Assert element [#{@action.org_element.name}] is disabled.", @action.is_disabled(), true, "==")
      end
      
      def assert_enabled()
        @assert.assert("Assert element [#{@action.org_element.name}] is enabled.", @action.is_enabled(), true, "==")
      end
      
      def assert_color(value)
        rgb = @action.color()
        hex = ColorUtils.NormalizeColorCode(ColorUtils.ConvertRgbToHex(rgb))
        @assert.assert("Assert element [#{@action.org_element.name}] color.", hex, value, "==")
      end
      
      def assert_backgroundcolor(value)
        rgb = @action.background_color()
        hex = ColorUtils.NormalizeColorCode(ColorUtils.ConvertRgbToHex(rgb))
        @assert.assert("Assert element [#{@action.org_element.name}] color.", hex, value, "==")
      end
      
      def assert_bordercolor(assertion,value)
        rgb =  @action.border_color()
        if @action.browser.downcase == "firefox"
          rgb.each do |color|
            hex = ColorUtils.NormalizeColorCode(ColorUtils.ConvertRgbToHex(color))
            @assert.assert("Assert element [#{@action.org_element.name}] border color.", hex, value, assertion)
          end
        else
          hex = ColorUtils.NormalizeColorCode(ColorUtils.ConvertRgbToHex(rgb))
          @assert.assert("Assert element [#{@action.org_element.name}] border color.", hex, value, assertion)
        end
        
      end
      
      def assert_alignment(value)
        @assert.assert("Assert element [#{@action.org_element.name}] alignment.", @action.alignment(), value, "==")
      end
      
      def assert_cssvalue(assertion, attr, value)
        if attr.downcase == "border-color" 
          assert_element_bordercolor(assertion,value)
        elsif attr.downcase == "font-weight"
          expectedValue = value.delete(' ').delete('"')
          actual = @action.css_value(attr)
          normal = ["100","200","300","400","500"]
          bold = ["600","700","800","900"]
          val = "normal" if normal.include?(val.strip)
          val = "bold" if bold.include?(val.strip)
          expectedValue = "normal" if normal.include?(expectedValue.strip)
          expectedValue = "bold" if bold.include?(expectedValue.strip)
          @assert.assert("Assert element css [#{attr}] value.", val, expectedValue, "==")
        elsif ["color", "background-color","outline-color"].include?(attr.downcase)
          rgb =  @action.css_value(attr)
          hex = ColorUtils.NormalizeColorCode(ColorUtils.ConvertRgbToHex(rgb))
          @assert.assert("Assert element [#{@action.org_element.name}] css [#{attr}] value.", hex, value, assertion)
        else
          @assert.assert("Assert element [#{@action.org_element.name}] css [#{attr}] value.", @action.cssvalue(attr), value, assertion)
        end
      end
      
      def assert_checked()
        @assert.assert("Assert element [#{@action.org_element.name}] is checked.", @action.is_checked(), true, "==")
      end

      def assert_notchecked()
        @assert.assert("Assert element [#{@action.org_element.name}] is not checked.", @action.is_not_checked(), true, "==")
      end
      
      def assert_focused()
        @assert.assert("Assert element [#{@action.org_element.name}] is focused.", @action.is_focused(), true, "==")
      end
      
      def assert_notfocused()
        @assert.assert("Assert element [#{@action.org_element.name}] is not focused.", @action.is_not_focused(), true, "==")
      end
      
      def assert_link_navigation(assertion, value, time)
        @action.click()
        browser = AutoEasy::Core::BrowserAction.new(@action.driver)
        browser.wait_for_ready(time)
        @assert.assert("Assert element [#{@action.org_element.name}] link navigation #{value}.", browser.get_url().downcase, value.downcase, assertion)
        browser.go_back()
      end
      
      def assert_link_popup(assertion, value, time)
        @action.click()
        sleep(2)
        browser = AutoEasy::Core::BrowserAction.new(@action.driver)
        browser.wait_for_ready(time)
        browser.switch_to_last_window
        @assert.assert("Assert element [#{@action.org_element.name}] link popup #{value}.", browser.get_url().downcase, value.downcase, assertion)
        browser.close_window()
      end
      
      def assert_viewable()
        @assert.assert("Assert element [#{@action.org_element.name}] is viewable.", @action.is_viewable(), true, "==")
      end
      
      def assert_notviewable()
        @assert.assert("Assert element [#{@action.org_element.name}] is not viewable.", @action.is_not_viewable(), true, "==")
      end
      
    end
  end
end
