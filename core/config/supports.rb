# encoding=utf-8
#Author: Stephen Zhang
#Self define current supports, what kinds of env/platform/browser/device/loglevel is available

require 'singleton'

module AutoEasy
  module Core
    class Supports
      include Singleton
      
      attr_accessor :environments
      attr_accessor :platforms
      attr_accessor :browsers
      attr_accessor :devices
      attr_accessor :loglevels
      attr_accessor :metakeys
      attr_accessor :assertions
      
      def setDefault()
        @environments = ['QA1','QA2','QA3']
        @platforms    = ['desktop','rwd','mobile']
        @browsers     = ['Chrome', 'Firefox', 'Marionette', 'IE']
        @devices      = ['Windows','Android','IPhone','Ipad']
        @loglevels    = ['Error','Warning','Info', 'Debug']
        #Allow meta keys for defining Elements
        @metakeys     = ['id', 'css', 'xpath', 'text','frame']
        #Operations
        @assertions    = ['equals', '=', '==', 'doesnotequals', '!=', 'gt', '>','gte', '>=','lt', '<','lte', '<=','match', '=~','doesnotmatch', '!=~','contains', 'in', 'doesnotcontain', 'notin']
      end
    end
  end
end

G_Supports ||= AutoEasy::Core::Supports.instance
G_Supports.setDefault()

