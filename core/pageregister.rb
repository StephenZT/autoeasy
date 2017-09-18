# encoding=utf-8
#Author: Stephen Zhang


module AutoEasy
  module Core
    module PageRegister
      #Store page register, it could be page class or page definitions with JSON format
      @RegisteredPages = Hash.new
      #Store page instance
      @PageInstances = Hash.new
      #Store page url if registered
      @PageUrls = Hash.new
      
      def self.registerPage(name, pagedef , opt={})
        if not @RegisteredPages.key?(name) then
          @RegisteredPages[name] = pagedef
          if opt != nil && opt.key?(:url)
            @PageUrls[name] = opt[:url]
          end
        else
          raise "Page name: #{name} already registered."
        end
      end
      
      def self.instance(name,opt={})
        if @RegisteredPages.key?(name)
          #Do you want to create force new page if refresh = true 
          refresh = (opt != nil && opt.key?(:force_refresh) && opt[:force_refresh] == true)
          if (not refresh) && @PageInstances.key?(name) then
            return @PageInstances[name]
          end 
          
          if @RegisteredPages[name].is_a?(Hash) then
            pageObj = Object::const_get('AutoEasy::Core::Page').new({:page_name=>name,:page_data=>@RegisteredPages[name],:page_url=>@PageUrls[name] })
            @PageInstances[name] = pageObj
            return pageObj  
          else
            pageObj = Object::const_get(@RegisteredPages[name]).new({:page_name=>name,:page_url=>@PageUrls[name]})
            @PageInstances[name] = pageObj
            return pageObj  
          end
        else
          puts "Page #{name} not registered" 
          return nil
        end
      end
      
      def self.isRegistered(name)
        return @RegisteredPages.key?(name) 
      end
      
    end
  end
end

PageRegister = AutoEasy::Core::PageRegister
