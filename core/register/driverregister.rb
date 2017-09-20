# encoding=utf-8
#Author: Stephen Zhang
require 'singleton'

module AutoEasy
  module Factories
    class DriverFactory
      include Singleton
       #Store current page
      attr_accessor :current_driver
      #Capybar driver
      attr_accessor :current_capybara_driver
      
      def getDriver(browser,  opt={})
        if @current_capybara_driver != nil
          @current_capybara_driver.quit()
        end
        @current_capybara_driver = DriverRegister.instance(browser)
        @current_driver = @current_capybara_driver.browser
        return @current_driver
      end
      
      def currentDriver()
        if @current_driver == nil
          getDriver("chrome")
        end
        return @current_driver
      end
      
      def currentCapybaraDriver()
        if :current_capybara_driver == nil
          getDriver("chrome")
        end
        return :current_capybara_driver
      end
    end
  end
end

DriverFactory ||= AutoEasy::Factories::DriverFactory.instance
