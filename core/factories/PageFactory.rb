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
        if G_PageRegister.isRegistered(name) then
          page_new = G_PageRegister.instancePage(name, opt)
          page_new.switchToPlatform(platform)
          @current_page = page_new
          return page_new
        else
          raise "Page name :#{name} not registered"
          return nil
        end
      end
      
    end
  end
end

G_PageFactory ||= AutoEasy::Factories::PageFactory.instance
