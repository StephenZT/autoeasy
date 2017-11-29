# encoding=utf-8
#Start_DOC
#Author::
#Desc:: visit page through pageName
#params::
#pageName::page name defined under project
#Returns::
#Example::example name
#When I visit "GD_OnlineActivation" page
#End_DOC
When(/^I visit "([^"]*)" page$/) do |pageName|
  next if G_Configuration.getSkipStep()

  pageName = VarUtil.toVaueIfIsVarialbe(pageName)

  get_page = G_PageFactory.getPage(pageName, G_ConfigHelper.get_platform(), {:force_refresh=>true})
  get_page.action().go_to(get_page.url)
end

Then(/^I am on the page "([^"]*)"$/) do |pageName|
  next if G_Configuration.getSkipStep()
  pageName = VarUtil.toVaueIfIsVarialbe(pageName)

  get_page = G_PageFactory.getPage(pageName, G_ConfigHelper.get_platform())
  get_page.assert().assert_url("contains",get_page.url)
end

#Start_DOC
#Author::
#Desc:: Visit page use the new url instead of the url defined in page
#params::
#pageName::page name defined under project
#url::url
#Returns::
#Example::
#When I visit "GD_OnlineActivation" page using Url "http://www.greendot.com/"
#End_DOC
When(/^I visit "([^"]*)" page using Url "([^"]*)"$/) do |pageName, url|
  next if G_Configuration.getSkipStep()

  get_page = G_PageFactory.getPage(pageName, G_ConfigHelper.get_platform(), {:force_refresh=>true})
  get_page.action().go_to(url)
end

#Start_DOC
#Author::
#Desc:: Using the url get from variable instead of the url defined in page
#params::
#pageName::page name defined under project
#urlVar::url get from Variable
#Returns::
#Example::
#Given I set Variable "NewUrl" to "SkinID=1"
#When I visit "GD_OnlineActivation" page using Url in variable "NewUrl"
#End_DOC
When(/^I visit "([^"]*)" page using Url in variable "([^"]*)"$/) do |pageName, urlVar|

end

#Start_DOC
#Author::
#Desc:: Visit the url with queryString appended
#params::
#pageName::page name defined under project
#queryString::the parameter append to url(Example: queryString "SkinID=1" in url "https://www.greendot.com/greendot/activation/online-activation-init?SkinID=1")
#Returns::
#Example::
#When I visit "GD_OnlineActivation" page using query string "PageId=1"
#End_DOC
When(/^I visit "([^"]*)" page using query string "([^"]*)"$/) do |pageName, queryString|
  
end

#Start_DOC
#Author::
#Desc:: Visit the url with queryString get from variable
#params::
#pageName::page name defined under project
#queryVar::the parameter get from variable
#Returns::
#Example::
#Given I set Variable "NewQueryString" to "PageId=1"
#When I visit "GD_OnlineActivation" page using query string in variable "NewQueryString"
#End_DOC
When(/^I visit "([^"]*)" page using query string in variable "([^"]*)"$/) do |pageName, queryVar|
 
end

#Start_DOC
#Author::
#Desc:: Set page as current page then you can use the element defined in that page
#params::
#pagename::page name defined under project
#Returns::
#Example::
#When I am on the page "GD_OnlineActivation"
#End_DOC
#When(/^I am on the page "([^"]*)"$/) do |pagename|
  # (puts 'Skipped, invalid step marked.'; next) if !(Util.isStepMarkedAsValid())
# 
  # retryCount = 1
  # maxRetries = 61 * 2
  # Pages.setPage(pagename)
  # while !(page.current_url.downcase.include? Pages.getPage().getUrl().downcase) && retryCount < maxRetries do
    # if retryCount % 6 == 0 then
      # LoggerTrace.Log("Retrying " + page.current_url + " for the " + retryCount.to_s + " time", LogLevel::Info)
    # end
    # retryCount = retryCount + 1
    # sleep(0.5)
  # end
  # #--------------Stephen zhang: for optional page -- Start
  # # If page is optional page, will set pagename_skipped value to true or false by real situation
  # # If pagename_skipped == ture, will skip any validates or operations that assosicated with this page or element in page
  # if !(Pages.getPage().isOptional) then
    # page.current_url.downcase.should have_text(Pages.getPage().getUrl().downcase)
  # else
    # if(page.current_url.downcase.include? Pages.getPage().getUrl().downcase) then
      # Variables.setVariable(Pages.getCurrentPage().downcase + '_isSkipped',false)
    # else
      # Variables.setVariable(Pages.getCurrentPage().downcase + '_isSkipped',true)
    # end
  # end
  # #--------------Stephen zhang: for optional page -- End
# 
  # Browser.action("waitForPageLoaded", :text=> 60)
  # # If setting Waiting_Overlay(when page load completed but not allow operate), it will waiting ovelay element invisible 10 seconds
  # if Variables.hasVariable('Waiting_Overlay') then
    # var = Variables.getVariable('Waiting_Overlay')
    # if(var.is_a?(Hash)) then
      # elementName = ''
      # if var[pagename] !=nil and var[pagename] !='' then
      # elementName = var[pagename].to_s
      # elsif var['default_overlay'] !=nil and var['default_overlay'] !='' then
        # elementName = var['default_overlay'].to_s
      # end
      # if(elementName != '') then
        # if Pages.getPage().elementExists(elementName) then
          # doaction("waitForInvisible", elementName, :text => 10)
        # end
      # end
    # end
  # end

#end


#Author: Stephen Zhang
#Desciption: check i am on the page 
#Arguments: page url 1 and page url2
When(/^I am on the page "([^"]*)" or page "([^"]*)"$/) do |arg1, arg2|
  # pages = Pages.getPages()
  # url1=arg1
  # url2=arg2
  # if !(url1.include? "www")
    # url1 = pages[arg1.downcase].getUrl()
  # end
  # if !(url2.include? "www")
    # url2 = pages[arg2.downcase].getUrl()
  # end
#  
  # retryCount=1
  # maxRetries = 61 * 2
  # while !(page.current_url.downcase.match(url1) or page.current_url.downcase.match(url2)) && retryCount < maxRetries do
    # if retryCount % 6 == 0 then
     # LoggerTrace.Log("Retrying " + page.current_url + "for the " + retryCount.to_s + " time", LogLevel::Info)
    # end
    # retryCount = retryCount + 1
    # sleep(0.5)
  # end
#   
  # if page.current_url.downcase.match(url1)
    # Pages.setPage(arg1.downcase)    
  # elsif page.current_url.downcase.match(url2)
    # Pages.setPage(arg2.downcase)
  # end
#   
  # page.current_url.should match("("+url1+"|"+url2+")")
end


#Author: Stephen Zhang
#Desciption: check i am on the page 
#Arguments: page url 1 and page url2,url3
When(/^I am on the page "([^"]*)" or page "([^"]*)" or page "([^"]*)"$/) do |arg1, arg2, arg3|
  # pages = Pages.getPages()
  # url1=arg1
  # url2=arg2
  # url3=arg3
  # if !(url1.include? "www")
    # url1 = pages[arg1.downcase].getUrl()
  # end
  # if !(url2.include? "www")
    # url2 = pages[arg2.downcase].getUrl()
  # end
  # if !(url3.include? "www")
    # url3 = pages[arg3.downcase].getUrl()
  # end
#   
  # retryCount=1
  # maxRetries = 61 * 2
  # while !(page.current_url.downcase.match(url1) or page.current_url.downcase.match(url2) or page.current_url.downcase.match(url3)) && retryCount < maxRetries do
    # if retryCount % 6 == 0 then
     # LoggerTrace.Log("Retrying " + page.current_url + "for the " + retryCount.to_s + " time", LogLevel::Info)
    # end
    # retryCount = retryCount + 1
    # sleep(0.5)
  # end
#   
  # page.current_url.should match("("+url1+"|"+url2+"|"+url3+")")
end



#Start_DOC
#Author::
#Desc:: support set current page for different platform
#params::
#desktopPageName::page name for desktop
#rwdPageName::page name for rwd
#Returns::
#Example::
#When I am on desktop "GD_OnlineActivation" page or on rwd "" page
#When I am on desktop "" page or on rwd "GD_OnlineActivation" page
#End_DOC
#Arguments: if you want to verify rwd page ,type the page name in rwd field, desktop by default
When(/^I am on desktop "([^"]*)" page or on rwd "([^"]*)" page$/) do |desktopPageName, rwdPageName|
  # (puts 'Skipped, invalid step marked.'; next) if !(Util.isStepMarkedAsValid())
# 
  # pages = Pages.getPages()
  # url =""
  # if Platform.to_s.downcase == "desktop" || Platform.to_s == "" || Platform == nil
    # if desktopPageName != nil
      # if  desktopPageName.to_s != ""
      # url = pages[desktopPageName.downcase].getUrl()
      # end
    # end
  # elsif  Platform.to_s.downcase == "rwd"
    # if rwdPageName != nil
      # if rwdPageName.to_s != ""
      # url = pages[rwdPageName.downcase].getUrl()
      # end
    # end
  # else
    # raise "could not find page with current platform!"
  # end
  # retryCount=1
  # maxRetries = 61 * 2
  # while !(page.current_url.downcase.match url) && retryCount < maxRetries do
    # if retryCount % 6 == 0 then
      # LoggerTrace.Log("Retrying " + page.current_url + "for the " + retryCount.to_s + " time", LogLevel::Info)
    # end
    # retryCount = retryCount + 1
    # sleep(0.5)
  # end
  # page.current_url.should match(url.to_s)
end

#Start_DOC
#Author::
#Desc:: Verify current url from different platform(Desktop or RWD)
#params::
#desktopUrl:: Url for desktop platform
#rwdUrl:: Url for rwd platform
#Returns:: True or False
#Example::
#When I verify desktop "www.greendot.com/?platform=desktop" url or rwd "" url
#When I verify desktop "" url or rwd "www.greendot.com/?platform=rwd" url
#End_DOC
When(/^I verify desktop "([^"]*)" url or rwd "([^"]*)" url$/) do |desktopUrl, rwdUrl|
  # (puts 'Skipped, invalid step marked.'; next) if !(Util.isStepMarkedAsValid())
# 
  # url =""
  # if Platform.to_s.downcase == "desktop" || Platform.to_s == "" || Platform == nil
    # if desktopUrl != nil
      # if  desktopUrl.to_s != ""
      # url = desktopUrl.to_s
      # end
    # end
  # elsif  Platform.to_s.downcase == "rwd"
    # if rwdUrl != nil
      # if rwdUrl.to_s != ""
      # url = rwdUrl.to_s
      # end
    # end
  # else
    # raise "could not find page with current platform!"
  # end
  # retryCount=1
  # maxRetries = 61 * 2
  # while !(page.current_url.match url) && retryCount < maxRetries do
    # if retryCount % 6 == 0 then
      # LoggerTrace.Log("Retrying " + page.current_url + " for the " + retryCount.to_s + " time", LogLevel::Info)
    # end
    # retryCount = retryCount + 1
    # sleep(0.5)
  # end
  # page.current_url.should match(url.to_s)
end

#Start_DOC
#Author::
#Desc:: Wait for page loaded
#params::
#pageName::page name defined under project
#sec:: max seconds for wait
#Returns:: True or False
#Example::
#When I wait for the page "GD_OnlineActivationInit" for "30" seconds
#End_DOC
When(/^I wait for the page "([^"]*)" for "([^"]*)" seconds$/) do |pageName, sec|
  # (puts 'Skipped, invalid step marked.'; next) if !(Util.isStepMarkedAsValid())
# 
  # retryCount = 1
  # maxRetries = sec.to_i * 2
  # Pages.setPage(pageName)
  # while !(page.current_url.downcase.include? Pages.getPage().getUrl().downcase) && retryCount < maxRetries do
    # if retryCount % 6 == 0 then
      # LoggerTrace.Log("Retrying " + page.current_url + "for the " + retryCount.to_s + " time", LogLevel::Info)
    # end
    # retryCount = retryCount + 1
    # sleep(0.5)
  # end
  # page.current_url.downcase.should have_text(Pages.getPage().getUrl().downcase)
end

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
  # (puts 'Skipped, invalid step marked.'; next) if !(Util.isStepMarkedAsValid())
# 
  # if(action == 'find') then
    # Capybara.ignore_hidden_elements = false
  # else
    # Capybara.ignore_hidden_elements = true
  # end
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
  # (puts 'Skipped, invalid step marked.'; next) if !(Util.isStepMarkedAsValid())
# 
  # orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true  # turn off reverse DNS resolution temporarily
# 
  # if Socket.do_not_reverse_lookup = orig
    # UDPSocket.open do |s|
      # s.connect '64.233.187.99', 1
      # Variables.setVariable(ipaddress,s.addr.last.to_s)
    # end
  # else
    # raise "turn off reverse DNS resolution temporarily is not successful"
  # end
  # LoggerTrace.Log("myip is: " + Variables.getVariable(ipaddress), LogLevel::Debug)
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
  # if action == "check" || action == "uncheck"
    # Util.using_hidden_elements() {doaction(action, elementName)}
  # else
    # doaction(action, elementName)
  # end
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
  # doaction(action, elementName, :text => text)
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
When(/^I (fill|select|fillIfExist) "([^"]*)" with variable "([^"]*)"$/) do |action, elementName, variable|
  #doaction(action, elementName, :text => Variables.getVariable(variable))
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
  #doaction("selectByIndex", elementName, :text => indexNumber)
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
  #doaction(action, elementName, :varname => varname)
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
When(/^I (storeattribute) "([^"]*)" value from "([^"]*)" to variable "([^"]*)"$/) do |action, attributeName, elementName, varname|
  #doaction(action, elementName, :attrname=>attributeName, :varname => varname)
end

#Start_DOC
#Author::
#Desc:: Verify Page contain or doesnotcontain the object
#params::
#action::doescontain|doesnotcontain|doesContainText|doesNotContainText|doesContainHtml|doesNotContainHtml|doesContainTitle|doesNotContainTitle
#pageObject:: element name or html content
#Returns:: True or False
#Example::
#When Page doescontain "FirstName_Input"
#When Page doesContainText "First Name"
#When Page doesContainHtml "<script id="toolbar-tpl-scriptId" fixed="true" prod="blog" skin="black" src="http://c.csdnimg.cn/public/common/toolbar/js/html.js" type="text/javascript"></script>"
#End_DOC
#---------------Steven Wang: Support retrieve the value in the multiple layers Hash
#Sample: "@ActicationMsgData[VIP_SUMMARY\\EN]"
When(/^Page (doescontain|doesnotcontain|doesContainText|doesNotContainText|doesContainHtml|doesNotContainHtml|doesContainTitle|doesNotContainTitle) "(.*)"$/) do |action, pageObject|
  # (puts 'Skipped, invalid step marked.'; next) if !(Util.isStepMarkedAsValid())
# 
  # if(!["doescontain","doesnotcontain"].include?(action))
    # if (pageObject != nil && pageObject.to_s[0,1] == "@")
      # str = pageObject.split('@')[1].to_s
      # if(str.include?("[") && str.include?("]"))
        # pageObject = Variables.getVariable(str.to_s[0, str.to_s.index("[")], str.to_s[str.to_s.index("[").to_i, (str.to_s.size-1)].gsub("\"", "").gsub("'", "").gsub("[", "").gsub("]", ""))
      # else
        # pageObject = Variables.getVariable(str)
      # end
    # end
    # doaction(action, "", :text => pageObject)
  # else
    # doaction(action, pageObject)
  # end

end

#Start_DOC
#Author::
#Desc:: execute java script
#params::
#script:: java script
#Returns:: the result of js execution
#Example::
#When I evaluate script "return document.readyState"
#End_DOC
When(/^I evaluate script "([^"]*)"$/) do |script|
  # (puts 'Skipped, invalid step marked.'; next) if !(Util.isStepMarkedAsValid())
# 
  # page.evaluate_script(script)
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
  #doaction("verifyElementText",elementName,:assertion=> assertion,:text=>text)
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
  #doaction("verifyElementText",elementName,:assertion=> assertion)
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
  #doaction("verifySelectedText",elementName,:assertion=> assertion,:text=>text)
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
  #doaction("verifySelectedText",elementName,:assertion=> assertion)
end

#Start_DOC
#Author::
#Desc:: Verify the text of alert (equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch) expected text
#params::
#assertion::equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch
#text::text in alert
#Returns:: True or False
#Example::
#When verify alert text equals "Account Alert"
#End_DOC
When(/^verify alert text (equals|contains|matches|doesnotequal|doesnotcontain|doesnotmatch) "([^"]*)"$/) do |assertion, text|
  #doaction("verifyAlertText", nil, :assertion=> assertion,:text=>text)
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
  #doaction("verifyElementValue",elementName,:assertion=> assertion,:text=>value)
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
  #doaction("verifyElementValue",elementName,:assertion=> assertion)
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
  #doaction("verifyElementTag",elementName,:assertion=> assertion,:text=>tagName)
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
  #doaction(action, elementName, :value => hexColor)
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
  # if action == "ischecked" || action == "isnotchecked"
    # Util.using_hidden_elements() {doaction(action, elementName)}
  # else
    # doaction(action, elementName)
  # end
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
  #doaction(action, elementName, :assertion=> assertion, :text => url)
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
  #doaction(action, elementName, :value => alignment)
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
  # options = options.split(",")
  # doaction(action, elementName, :options => options)
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
  # if action == "visible"
    # doaction("waitForVisible", elementName, :text => seconds)
  # else
    # doaction("waitForInvisible", elementName, :text => seconds)
  # end
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
  doaction("syncElement", elementName)
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
  # doaction("syncElement", elementName, :text => seconds)
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
  # if action == "Attribute"
    # doaction("waitForAttrValue", elementName, {:timeout => timeout, :value => value, :attrname =>attrname })
  # else
    # doaction("waitForCssValue", elementName, {:timeout => timeout, :value => value, :attrname =>attrname })
  # end
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
  # doaction(action, elementName, :attrname=>attrname,:assertion => assertion, :value=>value)
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
  # doaction(action, elementName, :attrname=>attrname,:assertion => assertion, :value => :default)
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
  # Util.using_hidden_elements() {
    # steps %Q{
      # Then verify the Attribute "content" of element "#{elementName}" #{assertion} value "#{value}"
    # }
  # }
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
  # Util.using_hidden_elements() {
    # steps %Q{
      # Then verify the Attribute "content" of element "#{elementName}" #{assertion} default value
    # }
  # }
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
  # doaction("isfocused", elementName)
end

#Start_DOC
#Author::
#Desc:: Set timeout for page loading
#params::
#sec:: timeout(seconds)
#Returns::
#Example::
#When I wait for page loaded for "20" seconds
#End_DOC
#sec: if sec set as "", will use the timeout in env.rb by default
When(/^I wait for page loaded for "([^"]*)" seconds$/) do |sec|
  # (puts 'Skipped, invalid step marked.'; next) if !(Util.isStepMarkedAsValid())
# 
  # Browser.action("waitForPageLoaded", :text=> sec)
end

#Start_DOC
#Author::
#Desc:: Open a new tab in browser
#params::
#Returns::
#Example::
#When I open new window
#End_DOC
#use this step to open a blank window which title = ""
When(/^I open new window$/) do
  # (puts 'Skipped, invalid step marked.'; next) if !(Util.isStepMarkedAsValid())
# 
  # Browser.action("open_new_window")
end

#Start_DOC
#Author::
#Desc:: Focus on the new opened tab
#params::
#title:: Page Title
#Returns::
#Example::
#When I movetoWindow "GetACardNow_Title"
#End_DOC
When(/^I movetoWindow "([^"]*)"$/) do |title|
  # (puts 'Skipped, invalid step marked.'; next) if !(Util.isStepMarkedAsValid())
# 
  # title = Util.getVarValue(title)
# 
  # Browser.action("movetowindow", :title=> title)
end

#Start_DOC
#Author::
#Desc:: Maximize the current window
#params::
#Returns::
#Example::
#When I maximize the window
#End_DOC
When(/^I maximize the window$/) do
  # (puts 'Skipped, invalid step marked.'; next) if !(Util.isStepMarkedAsValid())
# 
  # Browser.action("maximize_window")
end

#Start_DOC
#Author::
#Desc:: Close current winodw and move to new winodw
#params::
#title:: the title of page you want to move to
#Returns::
#Example::
#When I close and moveBacktoWindow "SendMoney_Title"
#End_DOC
When(/^I close and moveBacktoWindow "([^"]*)"$/) do |title|

  # title = Util.getVarValue(title)
# 
  # Browser.action("close_and_movebacktowindow", :title =>title)
end

#Start_DOC
#Author::
#Desc:: simulate action of close browser and reopen one to test different session cases
#params::
#Returns::
#Example::
#When I reset browser
#End_DOC
# Reset the session (i.e. remove cookies and navigate to blank page)
# Use this step to simulate action of close browser and reopen one to test different session cases
When(/^I reset browser$/) do
  # Browser.action("reset_browser")
end

#Start_DOC
#Author::
#Desc:: close current browser
#params::
#Returns::
#Example::
#When I close browser
#End_DOC
# close browser
When(/^I close browser$/) do   
     # page.driver.quit
     # sleep(1)
end

#Start_DOC
#Author::
#Desc:: clear cookies of browser
#params::
#Returns::
#Example::
#When I clear the cookies
#End_DOC
# Clear browser cookies
Then(/^I clear the cookies$/) do    
  # Capybara.current_session.driver.browser.manage.delete_all_cookies
end


#Start_DOC
#Author::
#Desc:: Reload current page
#params::
#Returns::
#Example::
#When I reload page
#End_DOC
When(/^I reload page$/) do
  # Browser.action("reload")
end

#Start_DOC
#Author::
#Desc:: simulate action of navigate back or forward with browser
#params::
#action:: back or forward
#Returns::
#Example::
#When I navigate back
#End_DOC
When(/^I navigate (back|forward)$/) do |action|
  # Browser.action(action)
end

#Start_DOC
#Author::
#Desc:: Simulate the key operations on keyboard
#params::
#keyboardOperation::tab|backspace|enter|escape|space|home|end|page_up|page_down|left|right|up|down
#Returns::
#Example::
#When I send tab key
#End_DOC
#send shortcuts keys
When(/^I send (tab|backspace|enter|escape|space|home|end|page_up|page_down|left|right|up|down) key$/) do |keyboardOperation|
  # (puts 'Skipped, invalid step marked.'; next) if !(Util.isStepMarkedAsValid())
# 
  # page.driver.browser.action.send_keys(keyboardOperation.to_sym).perform
end

#Start_DOC
#Author::
#Desc:: send combin keys like "alt+a" , "alt+control+a"
#params::
#inputkeys::
#Returns::
#Example::
#When I send key "alt+a"
#End_DOC
#send combin keys like "alt+a" , "alt+control+a"
When(/^I send key "([^"]*)"$/) do |inputkeys|
  # (puts 'Skipped, invalid step marked.'; next) if !(Util.isStepMarkedAsValid())
# 
  # step "I send key \"#{inputkeys}\" \"1\" times"
end

#Start_DOC
#Author::
#Desc::send keys from keyboard multiple times
#params::
#inputkeys::the key in keybord
#number:: the times you send a key
#Returns::
#Example::
#When I send key "space" "5" times
#End_DOC
When(/^I send key "([^"]*)" "([^"]*)" times$/) do |inputkeys, number|
  # (puts 'Skipped, invalid step marked.'; next) if !(Util.isStepMarkedAsValid())
# 
  # shortcutkeys =["tab","backspace","elementSelector","escape","space","home","end","page_up","page_down","control","shift","alt","delete","backspace","left","right","up","down","f1","f2","f3","f4","f5","f6","f7","f8","f9","F10","f11","f12"]
  # inputkeysarray = inputkeys.downcase.split("+")
  # index=0
  # formatedkeys = Array.new()
  # for key in inputkeysarray
    # if shortcutkeys.include? key
    # formatedkeys[index] = key.to_sym
    # else
    # formatedkeys[index] = key
    # end
    # index = index + 1
  # end
  # number.to_i.times do
    # page.driver.browser.action.send_keys(formatedkeys).perform
  # end
end

#Start_DOC
#Author::
#Desc:: accept or dismiss alert popup
#params::
#action::accept|dismiss
#Returns::
#Example::
#When I dismiss alert popup
#End_DOC
#use this step to deal with alert popup
When(/^I (accept|dismiss) alert popup$/) do |action|
  # Browser.action(action)
end

#Start_DOC
#Author::
#Desc:: fill alert with specific text
#params::
#text::text you want fill in alert
#Returns::
#Example::
#When I fill alert with "Gordon James"
#or
#When I set variable "text" to "Gordon James"
#When I fill alert with "@text"
#End_DOC
When(/^I fill alert with "([^"]*)"$/) do |text|

  # text = Util.getVarValue(text)
  # Browser.action("sendkeyToAlert", :text=> text)
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
  # (puts 'Skipped, invalid step marked.'; next) if !(Util.isStepMarkedAsValid())
# 
  # if(LoggerTrace.Logs[LogLevel::Error] != nil )
    # if(LoggerTrace.Logs[LogLevel::Info] != nil)
      # LoggerTrace.Logs[LogLevel::Info].each do |msg|
        # STDOUT.puts msg
      # end
    # end
  # end
# 
  # LoggerTrace.Logs[LogLevel::Error].should eq(nil)
end

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
#Desc:: Upload a file with specific file path
#params::
#elementAttr :: only applys to element that the element tag should be <input> and the "type='file'"
#filePath:: the actual absolute file Path or file path in Variables you want to upload(the file should exist under project and checkin to P4,or others cannot the get upload file from same path by automation)
#Returns::
#Example::
#When I upload file into "UploadPhoto_FilePath" with file path "C:\william\QA\Cucumber\Projects\Walmart\Example of Page test_Scenario_Failed.png"
# or
#When I set variable "filePath" to "C:\william\QA\Cucumber\Projects\Walmart\Example of Page test_Scenario_Failed.png"
#When I upload file into "UploadPhoto_FilePath" with file path "@filePath"
#End_DOC
When(/^I upload file into "([^"]*)" with file path "([^"]*)"$/) do |elementName, filePath|
  # if Variables.hasVariable(filePath) then
    # filePath = Variables.getVariable(filePath)
  # end
# 
  # filePath = Util.getVarValue(filePath)
  # Util.using_hidden_elements() {doaction("upload", elementName, :filepath => filePath.to_s)}
end

#Start_DOC
#Author::
#Desc::
#params::
#action::
#url::
#Returns::
#Example::
#End_DOC
When(/^I save screenshot with name "([^"]*)"$/) do |arg1|
  # page.save_screenshot($scenario_name + "_" + arg1 + ".png")
end

#Start_DOC
#Author:: Stephen zhang
#Desc:: Steps after this step will be ignored if not adapt the condition
#params::
#varPageIsSkipped : variable name for storing optional page is skipped or not
#Returns::
#Example:: if optional OOW page is skipped, all steps under this will execute
# I execute below steps if page "OOW" was skipped
#End_DOC
When(/^I execute below steps if page "([^"]*)" (was|wasnot) skipped$/) do |pagename, action|
  # if !Variables.hasVariable(pagename.downcase + '_isSkipped') then
    # puts "Page '" + pagename.downcase + "' is not an optional page, this step do nothing"
    # Variables.setVariable('steps_in_section_is_valid_flag', true)
  # else
    # if Variables.getVariable(pagename.downcase + '_isSkipped') then
      # Variables.setVariable('steps_in_section_is_valid_flag', action=='was' ? true : false)
    # else
      # Variables.setVariable('steps_in_section_is_valid_flag', action=='was' ? false : true)
    # end
  # end
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