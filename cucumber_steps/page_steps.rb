# encoding=utf-8

#==========================Action Steps===========================================================
#Start_DOC
#Author::
#Desc:: visit page through pageName
#params::
#pageName::page name defined under project
#Returns::
#Example::example name
#When I visit "GD_OnlineActivation" page, if arg start with @ will be treat as varialbe in G_Variables
#End_DOC
When(/^I visit "([^"]*)" page$/) do |pageName|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  pageName = VarUtil.toVaueIfIsVarialbe(pageName)

  get_page = G_PageFactory.getPage(pageName, G_ConfigHelper.get_platform(), {:force_refresh=>true})
  get_page.action().go_to(get_page.url)
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
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  pageName = VarUtil.toVaueIfIsVarialbe(pageName)
  url = VarUtil.toVaueIfIsVarialbe(url)

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
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  pageName = VarUtil.toVaueIfIsVarialbe(pageName)
  url = G_Variables.getVariable(urlVar)

  get_page = G_PageFactory.getPage(pageName, G_ConfigHelper.get_platform(), {:force_refresh=>true})
  get_page.action().go_to(url)
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
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  pageName = VarUtil.toVaueIfIsVarialbe(pageName)
  queryString = VarUtil.toVaueIfIsVarialbe(queryString)

  get_page = G_PageFactory.getPage(pageName, G_ConfigHelper.get_platform(), {:force_refresh=>true})
  get_page.action().go_to(get_page.url + "?" + queryString)
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
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  pageName = VarUtil.toVaueIfIsVarialbe(pageName)
  queryString = G_Variables.getVariable(queryVar)

  get_page = G_PageFactory.getPage(pageName, G_ConfigHelper.get_platform(), {:force_refresh=>true})
  get_page.action().go_to(get_page.url + "?" + queryString)
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
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  pageName = VarUtil.toVaueIfIsVarialbe(pageName)
  sec = VarUtil.toVaueIfIsVarialbe(sec)
  get_page = G_PageFactory.getPage(pageName, G_ConfigHelper.get_platform(), {:force_refresh=>true})
  get_page.action().wait_for_url(sec)
end



# encoding=utf-8

#Start_DOC
#Author:: 
#Desc:: Used when a link has _target=blank to switch back to the main window
#Returns:: 
#Example:: 
     #When I switch to the main window
#End_DOC
When(/^I switch to the main window$/) do
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  sleep(2)
  G_PageFactory.getCurrentPage().action().switch_to_first_window()
end

#Start_DOC
#Author::  
#Desc:: Used when a link has _target=blank to switch to the new window the link opened
#Returns:: 
#Example:: 
     #When I switch to the most recent window
#End_DOC
When(/^I switch to the most recent window$/) do
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  sleep(2)
  G_PageFactory.getCurrentPage().action().switch_to_last_window()
end


#Start_DOC
#Author::  
#Desc:: Used when a link has _target=blank to switch to the new window the link opened
#Returns:: 
#Example:: 
     #When I switch to the most recent window
#End_DOC
When(/^I close windows except main window$/) do
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  sleep(2)
  G_PageFactory.getCurrentPage().action().close_windows_except_main()
end

#Start_DOC
#Author::  
#Desc:: Used when a link has _target=blank to switch to the new window the link opened
#Returns:: 
#Example:: 
     #When I switch to the most recent window
#End_DOC
When(/^I close last window and switch back to window$/) do
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  sleep(2)
  G_PageFactory.getCurrentPage().action().close_and_switchback_window()
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
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  G_PageFactory.getCurrentPage().evaluate_script(script)
end


#==========================Verify Steps===========================================================
#Author: Stephen Zhang
#Desciption: check i am on the page 
Then(/^I am on the page "([^"]*)"$/) do |pageName|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  pageName = VarUtil.toVaueIfIsVarialbe(pageName)

  get_page = G_PageFactory.getPage(pageName, G_ConfigHelper.get_platform())
  get_page.assert().assert_url("contains",get_page.url)
end

#Author: Stephen Zhang
#Desciption: check i am on the page 
#Arguments: page url 1 and page url2
When(/^I am on the page "([^"]*)" or page "([^"]*)"$/) do |pageName1, pageName2|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  pageName1 = VarUtil.toVaueIfIsVarialbe(pageName1)
  pageName2 = VarUtil.toVaueIfIsVarialbe(pageName2)
  get_page_1 = G_PageFactory.getPage(pageName1, G_ConfigHelper.get_platform(), {:force_refresh=>true})
  get_page_2 = G_PageFactory.getPage(pageName2, G_ConfigHelper.get_platform(), {:force_refresh=>true})

  urls = []
  urls.push(get_page_1.url)
  urls.push(get_page_2.url)
  
  get_page_1.assert().assert_url_in(urls)
  
  if(get_page_1.action().get_url().downcase.include? get_page_1.url.downcase)
    G_PageFactory.setCurrentPage(get_page_1)
  end

  if(get_page_2.action().get_url().downcase.include? get_page_2.url.downcase)
    G_PageFactory.setCurrentPage(get_page_2)
  end
    
end

#Author: Stephen Zhang
#Desciption: check i am on the page 
#Arguments: page url 1 and page url2,url3
When(/^I am on the page "([^"]*)" or page "([^"]*)" or page "([^"]*)"$/) do |pageName1, pageName2, pageName3|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  pageName1 = VarUtil.toVaueIfIsVarialbe(pageName1)
  pageName2 = VarUtil.toVaueIfIsVarialbe(pageName2)
  get_page_1 = G_PageFactory.getPage(pageName1, G_ConfigHelper.get_platform(), {:force_refresh=>true})
  get_page_2 = G_PageFactory.getPage(pageName2, G_ConfigHelper.get_platform(), {:force_refresh=>true})
  get_page_3 = G_PageFactory.getPage(pageName3, G_ConfigHelper.get_platform(), {:force_refresh=>true})

  urls = []
  urls.push(get_page_1.url)
  urls.push(get_page_2.url)
  urls.push(get_page_3.url)
  
  get_page_1.assert().assert_url_in(urls)
  
  if(get_page_1.action().get_url().downcase.include? get_page_1.url.downcase)
    G_PageFactory.setCurrentPage(get_page_1)
  end

  if(get_page_2.action().get_url().downcase.include? get_page_2.url.downcase)
    G_PageFactory.setCurrentPage(get_page_2)
  end
  
  if(get_page_3.action().get_url().downcase.include? get_page_3.url.downcase)
    G_PageFactory.setCurrentPage(get_page_3)
  end
end

#Start_DOC
#Author::  
#Desc:: The text  not exists somewhere on page
#params:: 
#pageTitle::pageTitle in the page
#Returns:: 
#Example:: 
     #Then Page has title "Send Money Feature"
#End_DOC
Then(/^Page has title "([^"]*)"$/) do |pageTitle|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  pageTitle = VarUtil.toVaueIfIsVarialbe(pageTitle)

  G_PageFactory.getCurrentPage().assert().assert_title("==",pageTitle)
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
When(/^Page (doesContainText|doesNotContainText|doesContainHtml|doesNotContainHtml|doesContainTitle|doesNotContainTitle) "(.*)"$/) do |action, text|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  G_PageFactory.getCurrentPage().assert().assert_text_in_page_source("contains",text)
end

When(/^Page (doescontain|doesnotcontain) "(.*)"$/) do |action, elementName|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  G_PageFactory.getCurrentPage().getElement(elementName).is_valid()
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
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  
  do_action = G_PageFactory.getCurrentPage().action()
  do_assert = G_PageFactory.getCurrentPage().assert() 
  do_assert.assert_text(assertion,do_action.alert_text())
end


#========================================================Unimplemented=======================================================

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
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  sec = VarUtil.toVaueIfIsVarialbe(sec)
  do_action = G_PageFactory.getCurrentPage().action()
  do_action.wait_for_ready(sec)
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
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  sec = VarUtil.toVaueIfIsVarialbe(sec)
  do_action = G_PageFactory.getCurrentPage().action()
  do_action.open_new_window()
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
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  title = VarUtil.toVaueIfIsVarialbe(title)
  do_action = G_PageFactory.getCurrentPage().action()
  do_action.switch_to_window(title)
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
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  
  do_action = G_PageFactory.getCurrentPage().action()
  do_action.maximize_window()
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
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  title = VarUtil.toVaueIfIsVarialbe(title)
  
  do_action = G_PageFactory.getCurrentPage().action()
  do_action.close_and_switchback_window()
  do_action.switch_to_window(title)
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
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  
  do_action = G_PageFactory.getCurrentPage().action()
  do_action.reset_browser()
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
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  
  do_action = G_PageFactory.getCurrentPage().action()
  do_action.close_window() 
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
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  
  do_action = G_PageFactory.getCurrentPage().action()
  do_action.reset_browser() 
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
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  
  do_action = G_PageFactory.getCurrentPage().action()
  do_action.reload(20) 
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
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  do_action = G_PageFactory.getCurrentPage().action()
  
  case(action)
  when "back"  
    do_action.go_back()
  when "forward"
    do_action.go_forward()
  else
    raise "Not support action #{action}"
  end 
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
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  
  do_action = G_PageFactory.getCurrentPage().action()
  do_action.sendkey(keyboardOperation.to_sym)
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
  step "I send key \"#{inputkeys}\" \"1\" times"
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
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  shortcutkeys =["tab","backspace","elementSelector","escape","space","home","end","page_up","page_down","control","shift","alt","delete","backspace","left","right","up","down","f1","f2","f3","f4","f5","f6","f7","f8","f9","F10","f11","f12"]
  inputkeysarray = inputkeys.downcase.split("+")
  index=0
  formatedkeys = Array.new()
  for key in inputkeysarray
    if shortcutkeys.include? key
    formatedkeys[index] = key.to_sym
    else
    formatedkeys[index] = key
    end
    index = index + 1
  end

  do_action = G_PageFactory.getCurrentPage().action()
  number.to_i.times do
    do_action.sendkey()
  end
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
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  do_action = G_PageFactory.getCurrentPage().action()
  case (action)
  when "accept"
    do_action.alert_accept()
  when "dismiss"
    do_action.alert_dismiss()
  else
    raise "Not support action #{action}"
  end
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
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  text = VarUtil.toVaueIfIsVarialbe(text)
  
  do_action = G_PageFactory.getCurrentPage().action()
  do_action.sendkey_to_alert(text)
  # text = Util.getVarValue(text)
  # Browser.action("sendkeyToAlert", :text=> text)
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
When(/^I save screenshot with name "([^"]*)"$/) do |flag|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  flag = VarUtil.toVaueIfIsVarialbe(flag)

  do_action = G_PageFactory.getCurrentPage().action()
  do_action.save_screenshot($scenario_name + "_" + flag + ".png")
end

