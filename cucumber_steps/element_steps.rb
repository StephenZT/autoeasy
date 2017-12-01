# encoding=utf-8
#==========================Action Steps===========================================================
#Start_DOC
#Author::
#Desc:: find or ignore hidden elements
#params::
#action::find or ignore
#Returns::
#Example::
#When I find hidden elements
#When I ignore hidden elements
#End_DOC
When(/^I (find|ignore) hidden elements$/) do |action|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  if(action == 'find') then
    G_DriverFactory.currentCapybaraDriver.ignore_hidden_elements = false
  else
    G_DriverFactory.currentCapybaraDriver.ignore_hidden_elements = true
  end
end



#Start_DOC
#Author::
#Desc:: (click|clearvalue|mouseover|check|uncheck|clickIfExist|doubleclick|jsclick) element
#params::
#action::click|clearvalue|mouseover|check|uncheck|clickIfExist|doubleclick|jsclick
#elementName::element name which defined in pages
#Returns::
#Example::
#When I click "Continue_Button"
#When I mouseover 'My Account'
#End_DOC
When(/^I (click|clearvalue|mouseover|check|uncheck|clickIfExist|doubleclick|jsclick) "([^"]*)"$/) do |action, elementName|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  do_action = G_PageFactory.getCurrentPage().getElement(elementName).action()
  case(action)
  when "click",clickIfExist
      do_action.click()
    when "clearvalue",
      do_action.clear_value()
    when "mouseover",
      do_action.mouse_over()      
    when "check"
      do_action.check()
    when "uncheck",
      do_action.uncheck()
    when "doubleclick",
      do_action.double_click()
    when "jsclick",
      do_action.js_click()       
    else
      raise "Unsupport action #{action}"
  end
end

#Start_DOC
#Author::
#Desc:: Fill or Select element with text
#params::
#action:: fill or select or fillIfExist
#elementName::element name which defined in pages
#text::the text you want fill or select
#Returns::
#Example::
#When I fill "FirstName_Input" with "Gordon"
#When I select "State_Dropdown" with "CA"
#End_DOC
When(/^I (fill|select|fillIfExist|selectIfExist) "([^"]*)" with "([^"]*)"$/) do |action, elementName, text|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  text = VarUtil.toVaueIfIsVarialbe(text)
  do_action = G_PageFactory.getCurrentPage().getElement(elementName).action()
  case(action)
    when "fill", "fillIfExist"
      do_action.fill(text)
    when "select", "selectIfExist"
      do_action.select("option",text)
    else
      raise "Unsupport action #{action}"
  end
end

#Start_DOC
#Author::
#Desc:: Fill or Select element with text from variable
#params::
#action:: fill or select or fillIfExist(will check if the element exist)
#elementName::element name which defined in pages
#text::the text you want fill or select get from variable
#Returns::
#Example::
#When I fill "FirstName_Input" with variable "FistName"
#When I select "State_Dropdown" with variable "State"
#When I fillIfExist "FirstName_Input" with variable "FistName"
#End_DOC
When(/^I (fill|select|fillIfExist) "([^"]*)" with variable "([^"]*)"$/) do |action, elementName, varName|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  text = G_Variables.getVarialbe(varName)
  do_action = G_PageFactory.getCurrentPage().getElement(elementName).action()
  case(action)
    when "fill", "fillIfExist"
      do_action.fill(text)
    when "select", "selectIfExist"
      do_action.select("option",text)
    else
      raise "Unsupport action #{action}"
  end
end

#Start_DOC
#Author::
#Desc:: Select value from dropdown list by index number
#params::
#action::select
#elementName::element name defined in pages
#indexNumber:: the index number with the option
#Returns::
#Example::
#When I select "State_Dropdown" by index "1"
#End_DOC
When(/^I (select) "([^"]*)" by index "(.*?)"$/) do |action, elementName, indexNumber|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  index = VarUtil.toVaueIfIsVarialbe(indexNumber).to_i
  do_action = G_PageFactory.getCurrentPage().getElement(elementName).action()
  do_action.select_by_index("option",index)
end

#Start_DOC
#Author::
#Desc:: Get the value or text from element and store to variables
#params::
#action::storetext|storevalue
#elementName::element name defined in pages
#varname::the name of variable you want to save the text or value into
#Returns:: Variable Name
#Example::
#When I storetext from "FirstName_Input" to variable "FirstName"
#When I storevalue from "State_Dropdown" to variable "StateValue"
#End_DOC
When(/^I (storetext|storevalue) from "([^"]*)" to variable "(.*?)"$/) do |action, elementName, varname|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  do_action = G_PageFactory.getCurrentPage().getElement(elementName).action()
  case(action)
    when "storetext"
      text = do_action.get_text()
      G_Variables.setVarialbe(varName, text)
    when "storevalue"
      text = do_action.get_value()
      G_Variables.setVarialbe(varName, text)
    else
      raise "Unsupport action #{action}"
  end
end

#Start_DOC
#Author::
#Desc:: Get the atrribute value from element and store to variables
#params::
#action::storeattribute
#elementName::element name defined in pages
#varname::the name of variable you want to save the text or value into
#Returns:: Variable Name
#Example::
#When I storeattribute "data-content" from "FirstName_Input" to variable "FirstName"
#End_DOC
When(/^I (storeattribute) "([^"]*)" value from "([^"]*)" to variable "([^"]*)"$/) do |action, attributeName, elementName, varName|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  do_action = G_PageFactory.getCurrentPage().getElement(elementName).action()
  case(action)
    when "storeattribute"
      text = do_action.attribute(attributeName)
      G_Variables.setVarialbe(varName, text)
    else
      raise "Unsupport action #{action}"
  end
end



#Start_DOC
#Author::
#Desc:: Verify the text of element (equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch) expected text
#params::
#elementName::element name
#assertion::equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch
#text::expected text you want to verify
#Returns:: True or False
#Example::
#When verify the text of element "FirstName_Input" equals "Gordon"
#End_DOC
When(/^verify the text of element "([^"]*)" (equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch) "([^"]*)"$/) do |elementName,assertion,text|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  text = VarUtil.toVaueIfIsVarialbe(text)
  G_PageFactory.getCurrentPage().getElement(elementName).assert().assert_text(assertion,text)
end

#Start_DOC
#Author::
#Desc:: Verify the text of element (equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch) default text you defined as ":text" in element
#params::
#elementName::element name
#assertion::equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch
#Returns:: True or False
#Example::
#When verify the text of element "FirstName_Input"  equals default text
#End_DOC
When(/^verify the text of element "([^"]*)" (equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch) default text$/) do |elementName,assertion|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  do_action = G_PageFactory.getCurrentPage().getElement(elementName).action()
  do_assert = G_PageFactory.getCurrentPage().getElement(elementName).assert() 
  do_assert.assert_text(assertion,do_action.get_text())
end

#Start_DOC
#Author::
#Desc:: Verify the selected text for the dropdown element with the given text
#params::
#elementName::element name: this has to be a dropdown element
#assertion::equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch
#text::expected text you want to verify
#Returns:: Step to Pass or Fail
#Example::
#When verify the seleted text of element "SelectLegal_DropDown" equals "Green Dot Prepaid Cards (sold at a Financial Service Center or Currency Exchange)"
#End_DOC
When(/^verify the selected text of element "([^"]*)" (equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch) "([^"]*)"$/) do |elementName,assertion,text|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  text = VarUtil.toVaueIfIsVarialbe(text)
  do_action = G_PageFactory.getCurrentPage().getElement(elementName).action()
  do_assert = G_PageFactory.getCurrentPage().getElement(elementName).assert() 
  do_assert.assert_text(assertion,text)
end

#Start_DOC
#Author::
#Desc:: Verify the selected text for the dropdown element with default text you defined as ":text" in element
#params::
#elementName::element name: this has to be a dropdown element
#assertion::equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch
#Returns:: Step to Pass or Fail
#Example::
#When verify the seleted text of element "SelectLegal_DropDown" equals default text
#End_DOC
When(/^verify the selected text of element "([^"]*)" (equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch) default text$/) do |elementName,assertion|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  
  do_action = G_PageFactory.getCurrentPage().getElement(elementName).action()
  do_assert = G_PageFactory.getCurrentPage().getElement(elementName).assert() 
  do_assert.assert_text(assertion,do_action.get_selected_text())
end



#Start_DOC
#Author::
#Desc:: Verify the value of element (equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch) expected value
#params::
#elementName:: element name
#assertion::equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch
#value::value of element
#Returns:: True or False
#Example::
#When verify the value of element "Account_Alert"  equals value "Account Alert"
#End_DOC
When(/^verify the value of element "([^"]*)" (equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch) value "([^"]*)"$/) do |elementName,assertion,value|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  value = VarUtil.toVaueIfIsVarialbe(value)
  do_assert = G_PageFactory.getCurrentPage().getElement(elementName).assert() 
  do_assert.assert_value(assertion,value)
end

#Start_DOC
#Author::
#Desc:: Verify the value of element (equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch) default value
#params::
#elementName:: element name
#assertion::equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch
#Returns:: True or False
#Example::
#When verify the value of element "Account_Alert"  equals default value
#End_DOC
When(/^verify the value of element "([^"]*)" (equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch) default value$/) do |elementName,assertion|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  do_action = G_PageFactory.getCurrentPage().getElement(elementName).action()
  do_assert = G_PageFactory.getCurrentPage().getElement(elementName).assert() 
  do_assert.assert_value(assertion,do_action.get_value())
end

#Start_DOC
#Author::
#Desc:: Verify the Tag Name of element (equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch) expected value
#params::
#elementName:: element name
#assertion::equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch
#tagName::Tag Name of element
#Returns:: True or False
#Example::
#When verify the tag of element "Account_Alert"  equals "div"
#End_DOC
When(/^verify the tag of element "([^"]*)" (equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch) "([^"]*)"$/) do |elementName,assertion,tagName|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  tagName = VarUtil.toVaueIfIsVarialbe(tagName)
  do_assert = G_PageFactory.getCurrentPage().getElement(elementName).assert() 
  do_assert.assert_tag(assertion,tagName)
end

#Start_DOC
#Author::
#Desc::Verify the hexcode of element
#params::
#action::backgroundcolor|color|border
#elementName::element name
#hexColor::hexColor code(like "#33333")
#Returns:: True or False
#Example::
#Then The backgroundcolor of element "FirstName_Input" is "" in hexCode
#End_DOC
Then(/^The (backgroundcolor|color|border) of element "([^"]*)" is "([^"]*)" in hexCode$/) do |action, elementName, hexColor|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  do_assert = G_PageFactory.getCurrentPage().getElement(elementName).assert()
  hexColor = VarUtil.toVaueIfIsVarialbe(hexColor) 
  case(action)
  when "backgroundcolor"
    do_assert.assert_backgroundcolor("==", hexColor)
  when "color"
    do_assert.assert_color("==", hexColor)
  when "border"
    do_assert.assert_bordercolor("==", hexColor)
  else
    "Raise not support action #{action}"      
  end
  
end

#Start_DOC
#Author::
#Desc::Verify the element isdisabled or isenabled or ischecked or isnotchecked or isviewable or isnotviewable or scrollintoview
#params::
#elementName::element name
#action::isdisabled|isenabled|ischecked|isnotchecked|isviewable|isnotviewable|scrollintoview
#Returns:: True or False
#Example::
#Then "ECA_CheckBox" field ischecked
#End_DOC
Then(/^"([^"]*)" field (isdisabled|isenabled|ischecked|isnotchecked|isviewable|isnotviewable|scrollintoview)$/) do |elementName,action|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  do_action = G_PageFactory.getCurrentPage().getElement(elementName).action()
  do_assert = G_PageFactory.getCurrentPage().getElement(elementName).assert()
  hexColor = VarUtil.toVaueIfIsVarialbe(hexColor) 
  case(action)
  when "isdisabled"
    do_assert.assert_disabled()
  when "isenabled"
    do_assert.assert_enabled()
  when "ischecked"
    do_assert.assert_checked()
  when "isnotchecked"
    do_assert.assert_notchecked()
  when "isviewable"
    do_assert.assert_viewable()
  when "isnotviewable"
    do_assert.assert_notviewable()
  when "scrollintoview"
    do_assert.scroll_into_view()
  else
    raise "Not support action #{action}"      
  end
end

#Start_DOC
#Author::
#Desc:: Verify new opened link
#params::
#action::linknavigation(open new url in current tab),linkpopup(open a new tab)
#elementName:: element name
#assertion:: is|equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch
#url::the link you clicked
#Returns:: True or False
#Example::
#Then I verify linknavigation of element "GetACard_Link" equals "https://www.greendot.com/greendot/getacardnow"
#End_DOC
Then(/^I verify (linknavigation|linkpopup) of element "([^"]*)" (is|equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch) "([^"]*)"$/) do |action, elementName ,assertion ,url|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  do_assert = G_PageFactory.getCurrentPage().getElement(elementName).assert()
  case(action)
  when "linknavigation"
    do_assert.assert_link_navigation(assertion,url)
  when "linkpopup"
    do_assert.assert_link_popup(assertion,url)
  else
    raise "Not support action #{action}"      
  end
end

#Start_DOC
#Author::
#Desc:: Verify the alignment of element
#params::
#action:: alignment
#elementName:: element name
#alignment:: (left|right|center)
#Returns:: True or False
#Example::
#Then alignment of element "TransactionHistory_Header" is "center"
#End_DOC
Then(/^The (alignment) of element "([^"]*)" is "([^"]*)"$/) do |action, elementName, alignment|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  alignment = VarUtil.toVaueIfIsVarialbe(alignment) 
  do_assert = G_PageFactory.getCurrentPage().getElement(elementName).assert()
  do_assert.assert_alignment(alignment)
end

#Start_DOC
#Author::
#Desc:: Verify the element has the expected options
#params::
#elementName::element name
#action::containoptions or doesnotcontainoptions
#options::options in dropdown list
#Returns:: True or False
#Example::
#Then verify element "State_Dropdown" containoptions "CA,DC"
#End_DOC
Then(/^verify element "([^"]*)" (containoptions|doesnotcontainoptions) "([^"]*)"$/) do |elementName,action, options|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  options = VarUtil.toVaueIfIsVarialbe(options) 
  do_assert = G_PageFactory.getCurrentPage().getElement(elementName).assert()
  case(action)
  when "containoptions"
    do_assert.assert_option_involved(options)
  when "doesnotcontainoptions"
    do_assert.assert_option_not_involved(options)
  else
    raise "Not support action #{action}"      
  end
end

#Start_DOC
#Author::
#Desc:: Wait element visible or invisble for seconds
#params::
#elementName::element name
#action:: visible or invisible
#seconds:: seconds for timeout
#Returns::
#Example::
#Then I wait till element "FirstName_Input" is visible for "30" seconds
#End_DOC
Then(/^I wait till element "([^"]*)" is (visible|invisible) for "([^"]*)" seconds$/) do |elementName, action, seconds|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  seconds = VarUtil.toVaueIfIsVarialbe(seconds) 

  do_action = G_PageFactory.getCurrentPage().getElement(elementName).action()
  case(action)
  when "visible"
    do_action.wait_for_visible(seconds)
  when "invisible"
    do_action.wait_for_invisible(seconds)
  else
    raise "Not support action #{action}"      
  end
end

#Start_DOC
#Author::
#Desc:: sync up element, to wait element visible and then invisble, but will not fail if any exception occured
#params::
#elementName::element name
#Returns::
#Example::
#Then I sync element "PB_Blocker"
#End_DOC
Then(/^I sync element "([^"]*)"$/) do |elementName|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  do_action = G_PageFactory.getCurrentPage().getElement(elementName).action()
  do_action.wait_for_visible(5)
  do_action.wait_for_invisible(20)
end

#Start_DOC
#Author::
#Desc:: sync up element, to wait element visible and then invisble, but will not fail if any exception occured
#params::
#elementName::element name
#Returns::
#Example::
#Then I sync element "PB_Blocker"
#End_DOC
Then(/^I sync element "([^"]*)" for "([^"]*)" seconds$/) do |elementName, seconds|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  seconds = VarUtil.toVaueIfIsVarialbe(seconds) 
  
  do_action = G_PageFactory.getCurrentPage().getElement(elementName).action()
  do_action.wait_for_visible(seconds)
  do_action.wait_for_invisible(seconds)
end

#Start_DOC
#Author::
#Desc:: wait till the Attribute or CssVaule of element equals the expected value
#params::
#action::Attribute or CssValue
#attrname::Attribute name or the name of CssValue
#elementName::element name
#value::the value of attribute or css
#timeout:: seconds for timeout
#Returns::
#Example::
#Then I wait till CssValue "color" of element "FirstName_Input" equals "#33333" for "30" seconds
#End_DOC
#Attribute: class, id, name, placeholder, href, type, value
#CssValue: color, background-color,border, width, height, font-size, font-family
Then(/^I wait till (Attribute|CssValue) "([^"]*)" of element "([^"]*)" equals "([^"]*)" for "([^"]*)" seconds$/) do |action, attrname, elementName, value,timeout|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  value = VarUtil.toVaueIfIsVarialbe(value)
  timeout = VarUtil.toVaueIfIsVarialbe(timeout) 

  do_action = G_PageFactory.getCurrentPage().getElement(elementName).action()
  case(action)
  when "Attribute"
    do_action.wait_for_attr_value(timeout,attrname,value)
  when "CssValue"
    do_action.wait_for_css_value(timeout,attrname,value)
  else
    raise "Not support action #{action}"      
  end  
end

#Start_DOC
#Author::
#Desc:: Verify the Attribute or CssVaule of element equals the expected value
#params::
#action::Attribute or CssValue
#attrname::Attribute name or the name of CssValue (like color for css value)
#elementName::element name
#assertion::equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch
#value::the value of attribute or css
#Returns:: True or False
#Example::
#When verify the CssValue "color" of element "FirstName_Input" equals value "#33333"
#End_DOC
#Attribute: class, id, name, placeholder, href, type, value
#CssValue: color, background-color,border, width, height, font-size, font-family
When(/^verify the (Attribute|CssValue) "([^"]*)" of element "([^"]*)" (equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch) value "([^"]*)"$/) do |action,attrname, elementName, assertion, value|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  value = VarUtil.toVaueIfIsVarialbe(value)
  timeout = VarUtil.toVaueIfIsVarialbe(timeout) 

  do_assert = G_PageFactory.getCurrentPage().getElement(elementName).assert()
  do_assert.assert_cssvalue(assertion, attrname, value)
  
end

#Start_DOC
#Author::
#Desc:: Verify the Attribute or CssVaule of element equals the expected value
#params::
#action::Attribute or CssValue
#attrname::Attribute name or the name of CssValue (like color for css value)
#elementName::element name
#assertion::equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch
#value::the value of attribute or css
#Returns:: True or False
#Example::
#When verify the CssValue "color" of element "FirstName_Input" equals default value
#End_DOC
#Attribute: class, id, name, placeholder, href, type, value
#CssValue: color, background-color,border, width, height, font-size, font-family
When(/^verify the (Attribute|CssValue) "([^"]*)" of element "([^"]*)" (equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch) default value$/) do |action,attrname, elementName, assertion|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  timeout = VarUtil.toVaueIfIsVarialbe(timeout) 

  do_assert = G_PageFactory.getCurrentPage().getElement(elementName).assert()
  do_action = G_PageFactory.getCurrentPage().getElement(elementName).action()
  do_assert.assert_cssvalue(assertion, attrname, do_action.get_text())

end

#Start_DOC
#Author:: Alex Zheng
#Desc:: Verify the meta content in html head section
#params::
#elementName:: the elementName that defined in page file
#assertion::equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch
#value::the value of meta content
#Returns:: True or False
#Example::
#Then verify the content of meta "meta_description" equals value "Great Features!"
#End_DOC
When(/^verify the content of meta "([^"]*)" (equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch) value "([^"]*)"$/) do |elementName, assertion, value|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  timeout = VarUtil.toVaueIfIsVarialbe(timeout) 
  value = VarUtil.toVaueIfIsVarialbe(value)
  
  do_assert = G_PageFactory.getCurrentPage().getElement(elementName).assert()
  do_assert.assert_cssvalue(assertion, "content", value)
end

#Start_DOC
#Author:: Alex Zheng
#Desc:: Verify the meta content in html head section
#params::
#elementName:: the elementName that defined in page file
#assertion::equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch
#value::the value of meta content
#Returns:: True or False
#Example::
#Then verify the content of meta "meta_description" equals default value
#End_DOC
When(/^verify the content of meta "([^"]*)" (equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch) default value$/) do |elementName, assertion|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  timeout = VarUtil.toVaueIfIsVarialbe(timeout) 

  do_action = G_PageFactory.getCurrentPage().getElement(elementName).action()
  do_assert = G_PageFactory.getCurrentPage().getElement(elementName).assert()
  do_assert.assert_cssvalue(assertion, "content", do_action.get_text())
end

#Start_DOC
#Author::
#Desc:: Verify the element is focused
#params::
#elementName::element name
#Returns:: True or False
#Example::
#When I verify element is focused on "FirstName_Input"

#End_DOC
When(/^I verify element is focused on "([^"]*)"$/) do |elementName|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  do_assert = G_PageFactory.getCurrentPage().getElement(elementName).assert()
  do_assert.assert_focused()
end

