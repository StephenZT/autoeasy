# encoding=utf-8
#Author: Stephen Zhang

module AutoEasy
  module Core
    class ElementAction
      #Native element find by selector
      attr_reader :org_element
      #Native element find by selector
      attr_reader :element
      #Store current browser (Maybe real action is different for browsers)
      attr_reader :browser
      #Store webdriver
      attr_reader :driver
      #wait for find element
      attr_reader :wait
      
      def initialize(el,driver,opts={})
        raise "The inputs are not valid element=>#{el} driver =#{driver} " if el==nil || (not el.is_a?(AutoEasy::Core::Element)) || driver == nil
        @driver = driver
        @org_element = el
        
        if opts != nil && opts.key?(:browser)
          @browser = opts[:browser]
        else
          @browser = "default"
        end 
        
        if opts != nil && opts.key?(:wait)
          @wait = Selenium::WebDriver::Wait.new(:timeout => opts[:wait]) 
        end 

        selector = el.getSelector()
        begin
          if @wait != nil then
            @element = wait.until { driver.first(selector[:validator], selector[:selector]) }
          else
            @element = driver.first(selector[:validator], selector[:selector]) 
          end
        rescue Exception =>msg
           puts "Unable to locate element [#{el.name}]."
        end
        
        if is_valid then
          switchFrame(el.name)
        end
      end
      
      def is_valid()
        return @element != nil
      end
      
      def switchFrame(name)
        frames = PageFactory.current_page.getFrameChain(name)
        frames.each do |frame|
          @driver.switch_to.frame(frame)
        end
      end
      
      def click()
        #workround for latest Firefox issue: https://github.com/mozilla/geckodriver/issues/653 
        if @element.tag_name.downcase=="a" && @browser.downcase == "marionette"
          @driver.execute_script("arguments[0].setAttribute('style','display:block');",@element)  
        end
        begin
          @element.click
        rescue Exception => msg
          @driver.execute_script("arguments[0].click();",@element)  if msg.to_s.include? "not clickable"
        end
      end
      
      alias_method  :click_if_exist, :click
      
      def js_click()
        @element.location_once_scrolled_into_view
        @driver.execute_script("return arguments[0].click();",@element)
      end
      
      def double_click()
        @driver.action.double_click(@element).perform
      end
      
      def mouse_over()
        @driver.action.move_to(@element).perform
      end
      
      def js_mouse_over()
        @driver.execute_script("if(document.createEvent){var evObj = document.createEvent('MouseEvents');evObj.initEvent('mouseover', true, false); arguments[0].dispatchEvent(evObj);} else if(document.createEventObject) { arguments[0].fireEvent('onmouseover');}",@element)
      end
      
      def fill(text)
        if @element.attribute('type') != "date"
          @element.send_keys [:control, 'a'], :backspace
        end
        
        if @browser.downcase == "marionette"
          @element.clear
        end
        
        @element.send_keys text
      end
      
      alias_method  :fill_if_exist, :fill
      
      def select(tag, text)
        if @element.selectable?
          if tag.downcase == "option" then 
            if @wait != nil then
              option = @wati.until { @element.find_element(:css,"option[value='#{text}']") }
            else
              option = @element.find_element(:css,"option[value='#{text}']") 
            end
            raise "Can't find option #{text}" if option == nil
            option.click
          else
            if @wait != nil then
              option = @wati.until { @element.find_element(:xpath,".(#{tag})[#{text}]") }
            else
              option = @element.find_element(:xpath,".(#{tag})[#{text}]") 
            end
            raise "Can't find option #{text}" if option == nil
            option.click
          end
        else
          raise "Current element is not selectable."  
        end
      end
      
      alias_method  :select_if_exist, :select
      
      def select_by_index(tag, text)
        if @element.selectable?
          if tag.downcase == "option" then 
            if @wait != nil then
              option = @wati.until { @element.find_element(:xpath,"option[#{text}]") }
            else
              option = @element.find_element(:xpath,"option[#{text}]") 
            end
            raise "Can't find option #{text}" if option == nil
            option.click
          else
            if @wait != nil then
              option = @wati.until { @element.find_element(:xpath,".(#{tag})[#{text}]") }
            else
              option = @element.find_element(:xpath,".(#{tag})[#{text}]") 
            end
            raise "Can't find option #{text}" if option == nil
            option.click
          end
        else
          raise "Current element is not slectable."  
        end
      end
      
      def select_by_value(tag, text)
        if @element.selectable?
          if tag.downcase == "option" then 
            if @wait != nil then
              option = @wati.until { @element.find_element(:xpath,"option[@value='#{text}']") }
            else
              option = @element.find_element(:xpath,"option[@value='#{text}']") 
            end
            raise "Can't find option #{text}" if option == nil
            option.click
          else
            if @wait != nil then
              option = @wati.until { @element.find_element(:xpath,".(#{tag})[@value='#{text}']") }
            else
              option = @element.find_element(:xpath,".(#{tag})[@value='#{text}']") 
            end
            raise "Can't find option #{text}" if option == nil
            option.click
          end
        else
          raise "Current element is not slectable."  
        end
      end
      
      
      def get_option_counts(tag)
        if @element.selectable?
          if tag.downcase == "option" then 
            if @wait != nil then
              option = @wati.until { @element.find_elements(:xpath,"option") }
            else
              option = @element.find_element(:xpath,"option") 
            end
            raise "Can't find option #{text}" if option == nil
            option.count
          else
            if @wait != nil then
              option = @wati.until { @element.find_element(:xpath,".(#{tag})") }
            else
              option = @element.find_element(:xpath,".(#{tag})") 
            end
            raise "Can't find option #{text}" if option == nil
            option.count
          end
        else
          raise "Current element is not slectable."  
        end
      end
      
      def get_options_text()
        optionstext = []
        Selenium::WebDriver::Support::Select.new(@element).options.each do |item|
          optionstext.push(item.text)
        end
        return optionstext
      end
      
      def get_selected_text()
        return Selenium::WebDriver::Support::Select.new(@element).first_selected_option.text
      end
      
      def get_text()
        return @element.text
      end
      
      def get_value()
        return @element.attribute('value')
      end
      
      def clear_value()
        len =@element.attribute('value').length
        attrmask = @element.attribute('data-mask') 
        if element.attribute('type') == "date" || (attrmask != nil && attrmask != '')
          @driver.execute_script("arguments[0].value='';", @element)
          @element.send_keys :delete
        else
          while(len>0)
            @element.send_keys :end
            @element.send_keys :backspace
            len =len-1
          end     
        end
      end
      
      def get_tag_name()
        return @element.tag_name
      end
      
      def is_disabled()
        isdisabled = false
        if @element.tag_name.downcase == "a"
          class_attr   = @element.attribute('class')
          onclick_attr = @element.attribute('onclick')
          isdisabled = ((class_attr!=nil)?class_attr.downcase.include?("disabled"):false) || ((onclick_attr!=nil)?onclick_attr.downcase.include?("false") :false)
        else
          isdisabled = !@element.enabled?
        end
        return isdisabled
      end
      
      def is_enabled()
        return ! isdisabled()
      end
      
      def color()
        return @element.css_value('color')
      end
      
      def background_color()
        return @element.css_value('background-color')
      end
      
      def border_color()
        if @browser.downcase == "firefox"
          borders = ["border-top-color", "border-bottom-color", "border-right-color","border-left-color"]  
          rgblist = []
          borders.each {|border| rgblist.push(@element.css_value(border))}
          return rgblist
        else
          return @element.css_value('border-color')  
        end
      end
      
      def alignment()
        return @element.css_value('text-align')
      end
      
      def attribute(name)
        return @element.attribute(name)
      end
      
      def set_attribute(name,value)
        @driver.execute_script("arguments[0].setAttribute('" + name + "', '" + value + "');", @element)
      end
      
      def css_value(name)
        return @element.css_value(name)
      end
      
      def is_checked()
        return @element.selected?
      end
      
      def is_not_checked()
        return !is_checked()
      end
      
      def check()
        if !is_checked()
          @driver.execute_script("return arguments[0].click();",@element)
        end
      end
      
      def uncheck()
        if is_checked()
          @driver.execute_script("return arguments[0].click();",@element)
        end
      end
      
      def is_focused()
        return @element.equals(@driver.switchTo().activeElement());
      end
      
      def is_not_focused()
        return !isfocused()
      end
      
      def scroll_into_view()
        @element.location_once_scrolled_into_view
      end
      
      def is_viewable()
        elementViewable = @driver.execute_script("return elementInViewport(arguments[0]);
              function elementInViewport(el) {
                var top = el.offsetTop;
                var left = el.offsetLeft;
                var width = el.offsetWidth;
                var height = el.offsetHeight;
              
                while(el.offsetParent) {
                  el = el.offsetParent;
                  top += el.offsetTop;
                  left += el.offsetLeft;
                }
              
                return (
                  top < (window.pageYOffset + window.innerHeight) &&
                  left < (window.pageXOffset + window.innerWidth) &&
                  (top + height) > window.pageYOffset &&
                  (left + width) > window.pageXOffset
                );
              }", @element)
        return elementViewable
      end
      
      def is_not_viewable()
        return !isviewable()
      end
      
      def is_visible()
        return @element.displayed?
      end
      
      def is_invisible()
        return !@element.displayed?
      end
      
      def wait_for_visible(time)
         wait = Selenium::WebDriver::Wait.new(:timeout=> time.to_i)    
         wait.until { @element.displayed? }       
      end

      def wait_for_invisible(time)
         wait = Selenium::WebDriver::Wait.new(:timeout=> time.to_i)    
         wait.until { !@element.displayed? }       
      end
      
      def wait_for_css_value(time, css_tag, value)
         wait = Selenium::WebDriver::Wait.new(:timeout=> time.to_i)    
         wait.until { @element.css_value(css_tag) == value }       
      end
      
      def wait_for_attr_value(time, attr_tag, value)
         wait = Selenium::WebDriver::Wait.new(:timeout=> time.to_i)    
         wait.until { @element.attribute(attr_tag) == value }       
      end
      
    end
  end
end
