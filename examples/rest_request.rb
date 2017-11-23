# encoding=utf-8
require File.expand_path(File.dirname(__FILE__)) + "/../Packages.rb"

def rest_examples()
  request = AutoEasy::Core::RestService.new("http://FinderService.svc/get?product=%{ProductCode}&environment=%{Environment}&value=%{LoadAmount}")
  request.execute("test", {"ProductCode"=>"12345","Environment"=>"QA4","LoadAmount"=>"10"})
  response = request.getResponse("test", "json")
  puts response
end
