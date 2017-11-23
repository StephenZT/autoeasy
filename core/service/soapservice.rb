# encoding=utf-8
#Author: Stephen Zhang
# Rest service wrap up
require File.expand_path(File.dirname(__FILE__)) + "/httphelper.rb"

require 'savon'
require 'nokogiri'

module AutoEasy
  module Core
    class SoapService
      def initialize(wsdl, namespaces, namespace_identifier, soap_header, opts={})
        @wsdl = wsdl
        @namespaces = namespaces
        @namespace_identifier = namespace_identifier
        @soap_header = soap_header
        @variables = opts
        @log = opts["savon_log"] != nil ? opts["savon_log"] : false
        @ntlm = opts["ntlm"] != nil ? opts["ntlm"] : nil
        @message_tag = opts["message_tag"] != nil ? opts["message_tag"] : nil
        @soap_version = opts["soap_version"] != nil ? opts["soap_version"] : 1
        @headers = opts["headers"] != nil ? opts["headers"] : nil
        @xmlMessage = opts["xmlMessage"] != nil ? opts["xmlMessage"] : nil
        @raise_errors = opts["raise_errors"] != nil ? opts["raise_errors"] : false
        opts.delete_if {|key, value| key == "savon_log" }
        @actions = Hash.new
        @rnamespaces = Hash.new
        @validations = Hash.new
        @responses = Hash.new
        @open_timeout = opts["timeout"] != nil ? opts["timeout"] : 600
        @read_timeout = opts["timeout"] != nil ? opts["timeout"] : 600
      end
    
      #add new action for  
      def addAction(action, message, remove_namespaces = nil, validations = nil)
        @actions[action.downcase] = message
        @rnamespaces[action.downcase] = remove_namespaces
        @validations[action.downcase] = validations
      end
      
      #execute soap request
      def execute(name, action, opts={})
        options = Hash.new
        opts.each do |key, value|
          options[key] = value
        end
        @variables.each do |key, value|
          if(options[key] == nil) then
            options[key] = value
          end
        end
        
        tempBody = overriderArguments(@actions[action.downcase], options, "")
        @responses[name.downcase] = soapRequest(action, @actions[action.downcase] != nil ? tempBody : nil)
        validate(name, action)
        return @responses[name.downcase]
      end
    
      #get response per given name
      def getResponse(name, type="raw")
        returnValue = @responses[name.downcase]
        case type
        when "json"
          returnValue = JSON.parse(returnValue.to_s)
        when "xml"
          returnValue = Nokogiri::XML(returnValue.to_s)
        when "sloppy"
          returnValue = Nokogiri::Slop(returnValue.to_s)
        when 
          returnValue = Nokogiri::HTML(returnValue.to_s)
        end
        
        return returnValue
      end
      
      private 
        def overriderArguments(currentEntry, options, key)
          tempBody = {}
          if(currentEntry.is_a?(Hash)) then
            currentEntry.each do |entry_key, value|
              tempBody[entry_key] = overriderArguments(value, options, entry_key)
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
        def soapRequest(action, message, opts={})
          if @ntlm !=nil
            HTTPI::Adapter.use = :net_http
            if @xmlMessage == nil
              client = Savon.client(wsdl: @wsdl, namespaces: @namespaces, namespace_identifier: @namespace_identifier.to_sym, soap_header: @soap_header, pretty_print_xml: true, log: @log, ntlm: @ntlm, :soap_version =>@soap_version, open_timeout: @open_timeout, read_timeout: @read_timeout)
            else
              client = Savon.client(wsdl: @wsdl, namespaces: @namespaces, namespace_identifier: @namespace_identifier.to_sym, soap_header: @soap_header, pretty_print_xml: true, log: @log, ntlm: @ntlm, :soap_version =>@soap_version, headers: @headers, raise_errors: false, open_timeout: @open_timeout, read_timeout: @read_timeout)
            end
           else
              if @xmlMessage == nil
                client = Savon.client(wsdl: @wsdl, namespaces: @namespaces, namespace_identifier: @namespace_identifier.to_sym, soap_header: @soap_header, pretty_print_xml: true, log: @log, :soap_version =>@soap_version, open_timeout: @open_timeout, read_timeout: @read_timeout)
              else
                client = Savon.client(wsdl: @wsdl, namespaces: @namespaces, namespace_identifier: @namespace_identifier.to_sym, soap_header: @soap_header, pretty_print_xml: true, log: @log, :soap_version =>@soap_version, headers: @headers, raise_errors: false, open_timeout: @open_timeout, read_timeout: @read_timeout)
              end
           end
           
           if @xmlMessage == nil 
             return client.call(action.downcase.to_sym, message: message, message_tag: @message_tag, response_parser: :rexml)
           else
             print("xml: @xmlMessage")
             return client.call(action.downcase.to_sym, message: message, message_tag: @message_tag, response_parser: :rexml, xml: @xmlMessage)
           end
        end
        
      private
        def validate(name, action)
          if(@validations[action.downcase] == nil || @responses[name.downcase] == nil)
            return
          end
          valResponse = getResponse(name.downcase, "xml")
          if(@rnamespaces[action.downcase]) then
            valResponse.remove_namespaces!
          end
          @validations[action.downcase].each do |validation|
            Assert.assert(validation["description"], valResponse.at_xpath(validation["xpath"]).content.to_s, validation["expected"], validation["operation"])
          end
        end
    end
  end
end





