# encoding=utf-8
#Author: Stephen Zhang
#Self define current supports

module AutoEasy
  module Core
    module Supports
      
      ENVIRONMENTS = ['QA1','QA2','QA3']
      PLATFORMS    = ['desktop','rwd','mobile']
      BROWSERS     = ['Chrome', 'Firefox', 'Marionette', 'IE']
      DEVICES      = ['Windows','Android','IPhone','Ipad']
      LOGLEVELS    = ['Error','Warning','Info', 'Debug']
      #Allow meta keys for defining Elements
      METAKEYS     = ['id', 'css', 'xpath', 'text','frame']
      #Operations
      ASSERTION    = ['equals', '=', '==', 'doesnotequals', '!=', 'gt', '>','gte', '>=','lt', '<','lte', '<=','match', '=~','doesnotmatch', '!=~','contains', 'in', 'doesnotcontain', 'notin']
    end
  end
end
