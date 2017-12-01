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
  # doaction("setAttribute", elementName, :attrname => attribute, :value => value)
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
#When I update element "test" with selector ".style" and validation type css for mobile"
#End_DOC
When(/^I update element "([^"]*)" with selector "([^"]*)" and validation type (xpath|css) for (mobile|desktop|rwd|none)$/) do |element, selector, validator, type|
  # element = Pages.getPage().getElement(element)
  # element.setSelector(selector, validator, type)
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