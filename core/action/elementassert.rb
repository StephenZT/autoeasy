# encoding=utf-8
# Author: Stephen Zhang
# 
require File.expand_path(File.dirname(__FILE__)) + "/../Assert.rb"
require File.expand_path(File.dirname(__FILE__)) + "/../../Utils/ColorUtil.rb"

module AutoEasy
  module Core
    class ElementAssert
      #Store ElementAction     
      attr_reader :element_action
      
      def initialize(element_act, opt={})
        @element_action = element_act
      end
    
      def assert_valid()
        Assert.assert("Assert element [#{@element_action.org_element.name}] is valid.", @element_action.is_valid(), true, "==")
      end
      
      def assert_invalid()
        Assert.assert("Assert element [#{@element_action.org_element.name}] is invalid.", @element_action.is_valid(), false, "==")
      end
      
      def assert_text(assertion, value)
        Assert.assert("Assert element [#{@element_action.org_element.name}] text.", @element_action.get_text(), value, assertion)
      end
      
      def assert_value(assertion, value)
        Assert.assert("Assert element [#{@element_action.org_element.name}] value.", @element_action.get_value(), value, assertion)
      end
      
      def assert_selected_text(assertion, value)
        Assert.assert("Assert element [#{@element_action.org_element.name}] selected text.", @element_action.get_selected_text(), value, assertion)
      end
      
      def assert_tag(assertion, value)
        Assert.assert("Assert element element [#{@element_action.org_element.name}] tag name.", @element_action.get_tag_name(), value, assertion)
      end
      
      def assert_option_involved(value)
        Assert.assert("Assert element [#{@element_action.org_element.name}] option [#{value}] involved.", @element_action.get_options_text().include?(value), true, "==")
      end
      
      def assert_option_not_involved(value)
        Assert.assert("Assert element [#{@element_action.org_element.name}] option [#{value}] not involved.", @element_action.get_options_text().include?(value), false, "==")
      end 
      
      def assert_disabled()
        Assert.assert("Assert element [#{@element_action.org_element.name}] is disabled.", @element_action.is_disabled(), true, "==")
      end
      
      def assert_enabled()
        Assert.assert("Assert element [#{@element_action.org_element.name}] is enabled.", @element_action.is_enabled(), true, "==")
      end
      
      def assert_color(value)
        rgb = @element_action.color()
        hex = ColorUtils.NormalizeColorCode(ColorUtils.ConvertRgbToHex(rgb))
        Assert.assert("Assert element [#{@element_action.org_element.name}] color.", hex, value, "==")
      end
      
      def assert_backgroundcolor(value)
        rgb = @element_action.background_color()
        hex = ColorUtils.NormalizeColorCode(ColorUtils.ConvertRgbToHex(rgb))
        Assert.assert("Assert element [#{@element_action.org_element.name}] color.", hex, value, "==")
      end
      
      def assert_bordercolor(assertion,value)
        rgb =  @element_action.border_color()
        if @element_action.browser.downcase == "firefox"
          rgb.each do |color|
            hex = ColorUtils.NormalizeColorCode(ColorUtils.ConvertRgbToHex(color))
            Assert.assert("Assert element [#{@element_action.org_element.name}] border color.", hex, value, assertion)
          end
        else
          hex = ColorUtils.NormalizeColorCode(ColorUtils.ConvertRgbToHex(rgb))
          Assert.assert("Assert element [#{@element_action.org_element.name}] border color.", hex, value, assertion)
        end
        
      end
      
      def assert_alignment(value)
        Assert.assert("Assert element [#{@element_action.org_element.name}] alignment.", @element_action.alignment(), value, "==")
      end
      
      def assert_cssvalue(assertion, attr, value)
        if attr.downcase == "border-color" 
          assert_element_bordercolor(assertion,value)
        elsif attr.downcase == "font-weight"
          expectedValue = value.delete(' ').delete('"')
          actual = @element_action.css_value(attr)
          normal = ["100","200","300","400","500"]
          bold = ["600","700","800","900"]
          val = "normal" if normal.include?(val.strip)
          val = "bold" if bold.include?(val.strip)
          expectedValue = "normal" if normal.include?(expectedValue.strip)
          expectedValue = "bold" if bold.include?(expectedValue.strip)
          Assert.assert("Assert element css [#{attr}] value.", val, expectedValue, "==")
        elsif ["color", "background-color","outline-color"].include?(attr.downcase)
          rgb =  @element_action.css_value(attr)
          hex = ColorUtils.NormalizeColorCode(ColorUtils.ConvertRgbToHex(rgb))
          Assert.assert("Assert element [#{@element_action.org_element.name}] css [#{attr}] value.", hex, value, assertion)
        else
          Assert.assert("Assert element [#{@element_action.org_element.name}] css [#{attr}] value.", @element_action.cssvalue(attr), value, assertion)
        end
      end
      
      def assert_checked()
        Assert.assert("Assert element [#{@element_action.org_element.name}] is checked.", @element_action.is_checked(), true, "==")
      end

      def assert_notchecked()
        Assert.assert("Assert element [#{@element_action.org_element.name}] is not checked.", @element_action.is_not_checked(), true, "==")
      end
      
      def assert_focused()
        Assert.assert("Assert element [#{@element_action.org_element.name}] is focused.", @element_action.is_focused(), true, "==")
      end
      
      def assert_notfocused()
        Assert.assert("Assert element [#{@element_action.org_element.name}] is not focused.", @element_action.is_not_focused(), true, "==")
      end
      
      def assert_link_navigation(assertion, value, time)
        @element_action.click()
        browser = AutoEasy::Core::BrowserAction.new(@element_action.driver)
        browser.wait_for_ready(time)
        Assert.assert("Assert element [#{@element_action.org_element.name}] link navigation #{value}.", browser.get_url().downcase, value.downcase, assertion)
        browser.go_back()
      end
      
      def assert_link_popup(assertion, value, time)
        @element_action.click()
        sleep(2)
        browser = AutoEasy::Core::BrowserAction.new(@element_action.driver)
        browser.wait_for_ready(time)
        browser.switch_to_last_window
        Assert.assert("Assert element [#{@element_action.org_element.name}] link popup #{value}.", browser.get_url().downcase, value.downcase, assertion)
        browser.close_window()
      end
      
      def assert_viewable()
        Assert.assert("Assert element [#{@element_action.org_element.name}] is viewable.", @element_action.is_viewable(), true, "==")
      end
      
      def assert_notviewable()
        Assert.assert("Assert element [#{@element_action.org_element.name}] is not viewable.", @element_action.is_not_viewable(), true, "==")
      end
      
    end
  end
end
