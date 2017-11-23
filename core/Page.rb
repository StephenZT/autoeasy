# encoding=utf-8
#Author: Stephen Zhang
# Define page with all element

module AutoEasy
  module Core
    class Page
      
      #hash to store element datas
      attr_reader :element_data
      #store url if page is url page
      attr_reader :url
      #store page properties
      attr_reader :name
       #If ture then allow override exist meta key
      attr_accessor :allow_override
      
      def initialize(opts={})
        @element_data = Hash.new
        @allow_override = false
        if opts!=nil && opts.key?(:page_url) then
          @url = opts[:page_url]
        end
        if opts!=nil && opts.key?(:page_name) then
          @name = opts[:page_name]
        end
        if opts!=nil && opts.key?(:page_data) then
          generateElements(opts[:page_data])
        end
        
      end
      
      def addElement(name, element)
        if @allow_override then
          @element_data[name] = element
        elsif not @element_data.key?(name)
          @element_data[name] = element
        else
          raise "Element #{name} already exist not allow override."          
        end
      end
      
      def getElement(name)
        if @element_data.key?(name)
          return @element_data[name]
        else
          return nil
        end
      end
      
      def getFrameChain(name)
        frames = []
        el = getElement(name)
        while el.getMeta(:frame) != nil
          fr = getElement(el.getMeta(:frame))
          if fr != nil
            frames.push(fr)
            el = fr
          else
            raise "Invalid frame name #{el.getMeta(:frame)}"
          end
        end
        return frames.reverse!
      end
      
      def switchToPlatform(platform)
        @element_data.each do |name, el|
          el.switchToPlatform(platform)
        end
      end
      
      #elements is json format data for generate elements
      # Format as:
      # {'userTextInput'=>{'desktop'=>{:id='user'}
      #            'mobile' =>{:id='user'} }
      #  'passwordInput'=>{'desktop'=>{:id='password'}
      #            'mobile' =>{:id='password'}}
      #  'loginButton'=>{'desktop'=>{:id='login'}
      #            'mobile' =>{:id='login'}}
      #}
      def generateElements(elements)
        raise "Not support the input data for page definition" if not elements.is_a?(Hash)
        elements.each do |el_name, el_define|
          raise "Not support the input element definition" if not elements[el_name].is_a?(Hash)
          addElement(el_name, AutoEasy::Core::Element.new(el_name,elements[el_name]))
        end      
      end
     
      def action(opts={})
        opts[:page] = self
        return AutoEasy::Core::BrowserAction.new(G_DriverFactory.currentDriver(), opts)
      end
      
      def assert(opts={})
        return AutoEasy::Core::BrowserAssert.new(action(opts),opts)
      end
       
    end
  end
end
