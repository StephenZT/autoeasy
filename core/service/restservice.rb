# encoding=utf-8
#Author: Stephen Zhang
# Rest service wrap up
require File.expand_path(File.dirname(__FILE__)) + "/httphelper.rb"

require 'nokogiri'

module AutoEasy
  module Core
    class RestService
      #Intialize rest service
      #url: url can with parameter as "pa"="%{arg}",%{arg} can be overrider if exist
      #parameters: could be form data that need post,%{arg} can be overrider if exist
      #body: request body , %{arg} can be overrider if exist
      #opts: overrider arguments 
      def initialize(url, parameters = nil, body = nil, opts={})
        @url = url
        @parameters = parameters
        @body = body
        @variables = opts
        @responses = Hash.new
      end

      #execute request
      #name : response name 
      #opts : overrider arguments
      #auth_name: authentication name that registered in G_AuthRegister
      def execute(name, opts={}, auth_name="")
        options = Hash.new
        getOptions(options, opts)
        getOptions(options, @variables)
    
        tempParameters = overrideArguments(@parameters, options, "")
        tempBody = overrideArguments(@body, options, "")
    
        if (@parameters == nil && @body == nil) then
          response = AutoEasy::Core::HttpHelper.getQuery(@url % options)
        else
          ntlm_auth = G_AuthRegister.getAuth(auth_name)
          response = AutoEasy::Core::HttpHelper.postRequest(@url % options, @parameters != nil ? tempParameters : nil, @body != nil ? tempBody.to_json : nil, ntlm_auth != nil && ntlm_auth != "" ? [ntlm_auth.username, ntlm_auth.domain, ntlm_auth.password] : nil)
        end
    
        @responses[name.downcase] = response
      end
      
      def getResponse(name, type="raw")
        response = @responses[name.downcase]
        if(response == nil) then
          raise "No response with the name " + name
        end
        returnValue = @responses[name.downcase]
        case type
        when "json"
          returnValue = JSON.parse(response)
        when "xml"
          returnValue = Nokogiri::XML(response) #parse me to XML later
        when 
          returnValue = Nokogiri::HTML(response)
        end
        return returnValue
      end
    
      #Override arugments before send request
      private
        def overrideArguments(currentEntry, options, key)
          tempBody = {}
          if(currentEntry.is_a?(Hash)) then
            currentEntry.each do |entry_key, value|
              tempBody[entry_key] = overrideArguments(value, options, entry_key)
            end
          else
            returnValue = currentEntry
            if(currentEntry.is_a?(String) && currentEntry["%{"]) then
              returnValue.replace currentEntry % options
            elsif(options[key] != nil)
              returnValue = options[key]
            end
            return returnValue
          end
          return tempBody
        end
    
      private
        def getOptions(options, toCombine)
            toCombine.each do |key, value|
              if(options[key] == nil) then
                options[key] = value
                if(key.is_a?(Symbol)) then
                  options[key.to_s] = value
                else
                  options[key.to_sym] = value
                end
              end
            end
         end
    end
  end
end



