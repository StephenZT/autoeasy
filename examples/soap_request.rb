# encoding=utf-8
require File.expand_path(File.dirname(__FILE__)) + "/../Packages.rb"
def soap_examples()
  require 'net/http'
  require 'securerandom'
  require 'savon'
  require 'rubygems'
  
  wsdl = "http://TestEngine.svc?wsdl"
  namespaces = {
                "xmlns:wsa" => "http://www.w3.org/2005/08/addressing",  
                "xmlns:soap" => "http://www.w3.org/2003/05/soap-envelope",
                "xmlns:v1" =>"http://processor/service/v1", 
                "xmlns:dog" => "http://schemas.datacontract.org/2004/07/Dog.ProcessorTransmission.Contract.Message",
                "xmlns:dog1" => "http://schemas.datacontract.org/2004/07/Dog.Core.Types", 
                "xmlns:dog2" =>"http://schemas.datacontract.org/2004/07/Dog.PTSTestEngine.Contract.Message", 
                "xmlns:v11" =>"http://processor/entity/balance/message/v1", 
                "xmlns:v12" =>"http://shared/data/v1"
                                  }
  
  namespace_identifier = :v1
  soapheader = {
                "wsa:To" => "http://TestEngine/PTSTestEngine.svc",
                "wsa:Action" => "http://processor/service/v1/IPTSTestEngine/GetCVVData",
                                  }
  options = {"savon_log" => false, "log_level"=>:debug, "message_tag"=>nil , "soap_version"=> 2}
  action_name = "get_cvv_data"
  
  soapService = AutoEasy::Core::SoapService.new("http://TestEngine.svc?wsdl", 
    namespaces, namespace_identifier, soapheader,
    options
  )
  
  soapService.addAction(
    action_name,
      {"v1:request" => 
        {
          "dog2:CallChainID" => 
          {
            "dog1:value" => SecureRandom.uuid
          },
          "v11:ExpirationDate" => "2020-01-31"
        }
       }
     )
   
  soap = soapService
  soap.execute("testGetCVVservice", "get_cvv_data", "v11:ExpirationDate" => "2020-07-31")
  response = soap.getResponse("testGetCVVservice")
  cvv = response.at_xpath("//getcvvdataresponse/getcvvdataresult/cvv").content.to_s
  puts "response=" + response
end