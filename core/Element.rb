# encoding=utf-8
#Author: Stephen Zhang
#
#  Page object for save element definitaions
#  E.g. 
# 
# el = AutoEasy::Core::Element.new(
#   {
#    'desktop'=>{:id=>'idname',:css=>'abc',:xpath=>'//body[abc]',:text=>'bbb'},
#    'mobile'=>{:id=>'idname2',:css=>'abc2',:xpath=>'//body[abc]2',:text=>'bbb2'}
#   }
# )
# 
# el.switchToPlatform('mobile')
# puts el.getSelector()
# el.printContent()

require File.expand_path(File.dirname(__FILE__)) + "/Config/Supports.rb"

module AutoEasy
  module Core
    class Element
      #hash to store meta key for Element
      attr_reader :meta_data
      #Store frame of current Element (if element belong to a frame), it should be an Element as well
      attr_reader :frame
      #If ture then allow override exist meta key
      attr_accessor :allow_override
      #Store current Element for which platform (desktop,mobile,customize)
      attr_reader :platform
      #Element name
      attr_reader :name
      
      #initalize element per given platform with meta data definitions
      #platform:  support @support_platforms
      #opts: {'desktop'=>{:id=>'123',:css=>'abc'}, 'mobile'=>{:id=>'234',:xpath=>'//abc',:text=>''}}
      def initialize(name, opts={})
        @meta_data = Hash.new
        @allow_override_meta = true
        @name = name
        #support platform
        @support_platforms  = G_Supports.platforms    
        #support meta keys
        @support_metakeys = G_Supports.metakeys       
       
        opts.each do |key_platform, value|
          if not @support_platforms.include?(key_platform) then
            puts "Ignore unsupport platform: #{key_platform}."
          end
          
          if value.is_a?(Hash) then
            @support_metakeys.each do |metakey|
              if value.key?(metakey.to_sym) then
                addMeta(key_platform, metakey.to_sym, value[metakey.to_sym])
              end
            end
          end
        end
      end
      #add meta to elemtn for different platform
      def addMeta(platform, key, value)
        if @support_platforms.include?(platform) then
          if not @meta_data.key?(platform)
            @meta_data[platform] = Hash.new
          end
          
          if @allow_override_meta then
            @meta_data[platform][key] = value
          elsif (@meta_data[platform][key] == nil ) then
            @meta_data[platform][key] = value
          else
            puts "Meta #{key}=>#{@meta_data[platform][key]} already exists, can not override it."
          end
        else
          raise "The given #{platform} platform not support."
        end
      end
      
      #Get currenct selector (find element required this)
      def getSelector()
        if @meta_data[@platform].key?(:id)
          selector = @meta_data[@platform][:id]
          validator = :id
        elsif @meta_data[@platform].key?(:css)
          selector = @meta_data[@platform][:css]
          validator = :css
        elsif @meta_data[@platform].key?(:xpath)
          selector = @meta_data[@platform][:xpath]
          validator = :xpath
        else
          raise "Can not find valid selector."
        end
        
        return {:selector => selector, :validator => validator}
      end
      #switch current platform (different selector will get per different platform)
      def switchToPlatform(platform)
        if @support_platforms.include?(platform) then
          @platform = platform
        else
          puts "The given #{platform} platform not support."
        end
      end
      
      #get meta data by key
      def getMeta(metaKey)
        if @support_metakeys.include?(metaKey.to_s) then
          if @meta_data[@platform].key?(metaKey) then
            return @meta_data[@platform][metaKey]
          else
            return nil
          end
        else
          puts "The given key '#{metaKey}' not support, it just support keys: #{@support_metakeys}."
          return nil
        end
      end
      
      #get default text for given element
      def defaultText()
        if @meta_data[@platform].key?(:text)
          return @meta_data[@platform][:text]
        else
          return ''
        end
      end
      #print element definitions
      def printContent()
        if @platform == nil
          raise "Please set platform at first."  
        end
        
        @meta_data[@platform].each do |key, value|
          puts "#{key} => #{value}"
        end
      end
      
      def action(opts={})
        return AutoEasy::Core::ElementAction.new(self,G_DriverFactory.currentDriver(),opts)
      end
      
      def assert(opts={})
        return AutoEasy::Core::ElementAssert.new(action(opts),opts)
      end
      
    end
  end
end
