# encoding=utf-8
#Author: Stephen Zhang
#Http request (post,get), it will be used in rest/soap service

require 'net/http'
require 'ntlm/http'
require 'json'

module AutoEasy
  module Core
    class HttpHelper
      def self.getQuery(uri, contentType = "application/json")
        if (uri.to_s[-1] == "=")
          uri.to_s[-1] = "%3D"
        end
        getUri = URI.parse(uri)
      
        http = Net::HTTP.new(getUri.host, getUri.port)
        if(uri.include? "https")
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
        request = Net::HTTP::Get.new(getUri.request_uri)
        response = http.request(request)
        return response.body
      end
      
      def self.postData(uri, object, contentType = "application/json")
        postUri = URI.parse(uri)
        http = Net::HTTP.new(postUri.host, postUri.port)
        if(uri.include? "https")
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
        request = Net::HTTP::Post.new(postUri.request_uri)
        request.add_field("Content-Type", contentType)
        response = http.request(request, object.to_json.to_s)
        return response.body
      end
      
      def self.postQuery(uri, parameters, contentType = "application/json")
        getUri = URI.parse(uri)
        http = Net::HTTP.new(getUri.host, getUri.port)
        if(uri.include? "https")
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
        request = Net::HTTP::Post.new(getUri.request_uri)
        request.set_form_data(parameters)
        response = http.request(request)
        return response.body
      end
      
      def self.postRequest(uri, parameters, object, ntlmAuth=nil, contentType="application/json", acceptEncoding="gzip,deflate", accept="application/json")
        postUri = URI.parse(uri)
        http = Net::HTTP.new(postUri.host, postUri.port)
        if(uri.include? "https")
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
      
        request = Net::HTTP::Post.new(postUri.path)
        request.ntlm_auth(ntlmAuth[0], ntlmAuth[1], ntlmAuth[2]) if ntlmAuth != nil && ntlmAuth != ""
      
        if parameters != nil
          request.set_form_data(parameters)
        end
          
        if object != nil  
          request.body = accept.include?("json") ? object : object.to_s 
          request.add_field("Content-Type", contentType)
          request.add_field("Accept-Encoding", acceptEncoding) 
          request.add_field("Accept", accept)
          response = http.request(request)
        else
          response = http.request(request)
        end
        return response.body
      end
    end
  end
end
