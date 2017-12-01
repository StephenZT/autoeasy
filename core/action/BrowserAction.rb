# encoding=utf-8
#Author: Stephen Zhang
require "win32ole"

module AutoEasy
  module Core
    class BrowserAction
      #Store webdriver
      attr_reader :page
      attr_reader :driver
      attr_reader :default_timeout
      
      def initialize(driver,opts={})
        if opts.key?(:page)
          @page = opts[:page]
        end
        @driver = driver
        @default_timeout = 120   
      end
      
      def wait_for_ready(timeout)
        wait = Selenium::WebDriver::Wait.new(:timeout=>timeout.to_i)          
        wait.until { evaluate_script("return document.readyState").to_s =="complete" }  
      end
      
      def evaluate_script(script)
        @driver.execute_script(script)
      end
      
      def visit()
        go_to(page.url)
      end
      
      def go_to(url)
        @driver.get(url)
        wait_for_ready(@default_timeout)
      end
      
      def go_back()
        @driver.go_back()
      end
      
      def go_forward()
        @driver.go_forward()
      end
      
      def reload(timeout)
        @driver.navigate.refresh
        wait_for_ready(timeout)
      end
      
      def title()
        @driver.title
      end
      
      def reset_browser(timeout)
        if @driver.browser.downcase == "firefox" || @driver.browser.downcase == "chrome"         
           @driver.execute_script("function deleteAllCookies() {var cookies = document.cookie.split(';'); for (var i = 0; i < cookies.length; i++) {var cookie = cookies[i];var eqPos = cookie.indexOf('=');var name = eqPos > -1 ? cookie.substr(0, eqPos) : cookie;document.cookie = name + '=;expires=Thu, 01 Jan 1970 00:00:00 GMT';}};deleteAllCookies();")
        end 
        
        @driver.manage.delete_all_cookies()   
      end
      
      def resize_to(width, height)
        @driver.manage.window.resize_to(width, height)
      end
      
      def maximize_window()
        @driver.manage.window.maximize
      end
      
      def open_new_window()
        @driver.execute_script( "window.open()" )
        @driver.switch_to.window( driver.window_handles.last )
      end
      
      def get_url()
        @driver.current_url
      end
      
      def get_page_source()
        return @driver.page_source
      end
      
      def switch_to_first_window()
        @driver.switch_to.window(@driver.window_handles.first)
      end
      
      def switch_to_last_window()
        @driver.switch_to.window(@driver.window_handles.last)
      end
 
      def close_window()
        @driver.execute_script( "window.close()" )
        switch_to_last_window()
      end
      
      def switch_to_default_content()
        @driver.switch_to.default_content
      end
      
      def switch_to_window(title)
        @driver.window_handles.each do |handle|
          @driver.switch_to.window(handle)
          sleep(0.5)
          break if title() == title
        end
      end 
      
      def close_and_switchback_window()
        if(@driver.window_handles.first != @driver.window_handles.last)
          switch_to_last_window()
          @driver.execute_script( "window.close()" )
        end
      end
      
      def close_windows_except_main()
        while(@driver.window_handles.first != @driver.window_handles.last)
            switch_to_last_window()
            @driver.execute_script( "window.close()" )
        end
      end
      
      
      def alert_accept()
        @driver.switch_to.alert.accept
      end
      
      def alert_dismiss()
        @driver.switch_to.alert.dismiss
      end
      
      def alert_accept()
        @driver.switch_to.alert.accept
      end
      
      def alert_text()
        return @driver.switch_to.alert.text
      end
      
      def sendkey(value)
        @driver.send_keys(value).perform
      end
      
      def sendkey_to_alert(value)
        if @driver.browser.downcase == "chrome"
          wsh = WIN32OLE.new("WScript.Shell")
          wsh.SendKeys(value)
        else
          @driver.switch_to.alert.send_keys(value)
        end
      end
      
      def wait_for_url(timeout)
        begin
          wait = Selenium::WebDriver::Wait.new(:timeout=>timeout.to_i)          
          wait.until { get_url().downcase.include? @page.url.downcase }
        rescue
          puts "Wait url :#{@page.url} timeout without raise error"
        end  
      end
      
      def save_screenshot(path)
        @driver.save_screenshot(path)
      end
      
    end
  end
end
