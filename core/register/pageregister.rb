# encoding=utf-8
#Author: Stephen Zhang


module AutoEasy
  module Core
    module PageRegister
      #Store page register, it could be page class or page definitions with JSON format
      @registered_pages = Hash.new
      #Store page instance
      @page_instances = Hash.new
      #Store page url if registered
      @page_urls = Hash.new
      
      def self.registerPage(name, pagedef , opt={})
        if not @registered_pages.key?(name) then
          @registered_pages[name] = pagedef
          if opt != nil && opt.key?(:url)
            @page_urls[name] = opt[:url]
          end
        else
          raise "Page name: #{name} already registered."
        end
      end
      
      def self.instance(name,opt={})
        if @registered_pages.key?(name)
          #Do you want to create force new page if refresh = true 
          refresh = (opt != nil && opt.key?(:force_refresh) && opt[:force_refresh] == true)
          if (not refresh) && @page_instances.key?(name) then
            return @page_instances[name]
          end 
          
          if @registered_pages[name].is_a?(Hash) then
            pageObj = Object::const_get('AutoEasy::Core::Page').new({:page_name=>name,:page_data=>@registered_pages[name],:page_url=>@page_urls[name] })
            @page_instances[name] = pageObj
            return pageObj  
          else
            pageObj = Object::const_get(@registered_pages[name]).new({:page_name=>name,:page_url=>@page_urls[name]})
            @page_instances[name] = pageObj
            return pageObj  
          end
        else
          puts "Page #{name} not registered" 
          return nil
        end
      end
      
      def self.isRegistered(name)
        return @registered_pages.key?(name) 
      end
      
    end
  end
end

G_PageRegister = AutoEasy::Core::PageRegister
