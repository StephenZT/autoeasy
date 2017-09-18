
require 'fileutils'
require 'singleton'
require 'securerandom'
require 'selenium-webdriver'

module AutoEasy
  module Factories
    class DriverFactory
      include Singleton
      
       #Store current page
      attr_accessor :current_driver
      
      def getDriver(browser,  opt={})
        @current_driver = Selenium::WebDriver.for(:chrome)
        return @current_driver
      end
      
      def currentDriver()
        if @current_driver == nil
          @current_driver = Selenium::WebDriver.for(:chrome)
        end
        return @current_driver
      end
      
    end
  end
end

DriverFactory ||= AutoEasy::Factories::DriverFactory.instance
