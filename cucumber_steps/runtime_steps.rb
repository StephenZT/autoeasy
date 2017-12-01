#Start_DOC
#Author::
#Desc:: Set the attribute of element to expected value
#params::
#attribute:: like "id" "src" "style" "title" in html
#elementName:: element name
#value:: the value of attribute like "height:60px" for attribute "style"
#Returns::
#Example::
#When I set the attribute "style" of element "FirstName_Input" to "height:20px"
#End_DOC
When(/^I set the attribute "([^"]*)" of element "([^"]*)" to "([^"]*)"$/) do |attribute, elementName, value|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  do_action = G_PageFactory.getCurrentPage().getElement(elementName).action()
  value = VarUtil.toVaueIfIsVarialbe(value)
  do_action.set_attribute(attribute,value)
end

#Start_DOC
#Author::
#Desc:: Set the selector for an element new value
#params::
#element:: name of element to find on page
#selector:: new selector to use to find element
#validator:: xpath or css
#type:: mobile, rwd, desktop or none
#Returns::
#Example::
#When I update element "test" with selector ".style" and validation type "css" for "mobile""
#End_DOC
When(/^I update element "([^"]*)" with selector "([^"]*)" and validation type "([^"]*)" for "([^"]*)"$/) do |element, selector, location, platform|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  do_element = G_PageFactory.getCurrentPage().getElement(elementName)
  selector = VarUtil.toVaueIfIsVarialbe(selector)
  platform = VarUtil.toVaueIfIsVarialbe(platform)
  location = VarUtil.toVaueIfIsVarialbe(location)
  
  do_element.addMeta(platform, selector.to_sym, location)
end

#Start_DOC
#Author::
#Desc:: Verify no error in log pool
#params::
#Returns:: True or False
#Example::
#When Verify there is no error in log pool
#End_DOC
When(/^Verify there is no error in log pool$/) do
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  LoggerTrace.assert_no_error_in_log()
end

#Start_DOC
#Author::
#Desc:: Get local IP Address and set as variable
#params::
#ipaddress:: Variable Name
#Returns:: Local Ip Address Set in variable
#Example::
#When I get my local IP Address and set as variable "ipaddress"
#End_DOC
When(/^I get my local IP Address and set as variable "([^"]*)"$/) do |ipaddress|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true  # turn off reverse DNS resolution temporarily

  if Socket.do_not_reverse_lookup = orig
    #METHOD (uses Google's address)
    UDPSocket.open do |s|
      s.connect '64.233.187.99', 1
      G_Variables.setVariable(ipaddress,s.addr.last.to_s)
    end
  else
    raise "turn off reverse DNS resolution temporarily is not successful"
  end

end