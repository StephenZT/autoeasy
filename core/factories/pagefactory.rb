# encoding=utf-8
#Author: Stephen Zhang
#
require 'singleton'

module AutoEasy
  module Factories
    class PageFactory
      include Singleton
      #Store current page
      attr_reader :current_page
      
      def getPage(name, platform, opt={})
        if AutoEasy::Core::PageRegister.isRegistered(name) then
          page_new = AutoEasy::Core::PageRegister.instance(name, opt)
          page_new.switchToPlatform(platform)
          @current_page = page_new
          return page_new
        else
          return nil
        end
      end
      
    end
  end
end

PageFactory ||= AutoEasy::Factories::PageFactory.instance
