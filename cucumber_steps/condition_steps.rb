#Start_DOC
#Author:: Stephen Zhang
#Desc:: steps execution condition reset, from this step ignore condition by 'I execute below steps if page "([^"]*)" (was|wasnot) skipped'
#params::
#varname: variable name
#action: is / is not
#Returns::
#Example:: set below steps valid if valraible 'skipped'==true, it means any step will be executed from this step
# I execute below steps if variable "skipped" is true
#End_DOC
When(/^I execute below steps if variable "([^"]*)" (is|isnot) true$/) do |varname, action|
  
end

#Start_DOC
#Author:: Stephen Zhang
#Desc:: steps execution condition reset, from this step ignore condition by 'I execute below steps if page "([^"]*)" (was|wasnot) skipped'
#params::
#Returns::
#Example:: set any step valid, it means any step will be executed from this step
# I stop checking step available
#End_DOC
When(/^I turn off ignore steps switch$/) do
end

When(/^I turn on ignore steps switch if "([^"]*)" (is|isnot) true$/) do |varname, action|
end