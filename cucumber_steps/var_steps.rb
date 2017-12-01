# encoding=utf-8

#==========================Action Steps===========================================================
#Start_DOC
#Author:: Unknown
#Desc:: set variable to value
#params:: 
#newVariable:: new variable name
#value:: values
#Returns:: G_Variables
#Example:: example name
               #When I set variable "Customer_Key" to "4439638"            
#End_DOC
Given(/^I set variable "([^"]*)" to "([^"]*)"$/) do |newVariable, value|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  value = VarUtil.toVaueIfIsVarialbe(value)
  G_Variables.setVariable(newVariable, value)
end

#Start_DOC
#Author:: Unknown
#Desc:: set special variable to value
#params:: 
#newVariable:: new variable name
#variableLocation:: defined the variable location
#value:: values 
#Returns:: G_Variables
#Example:: example name
               #When I set variable "Customer_Key" at "0\customerKey"　to "Customer_value"            
#End_DOC
Given(/^I set variable "([^"]*)" at "([^"]*)" to "([^"]*)"$/) do |newVariable, variableLocation, value|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  G_Variables.setVariable(newVariable, value, variableLocation)
end

#Start_DOC
#Author:: Unknown
#Desc:: set variable as random numeric string
#params:: 
#newVariable:: new variable name
#minLength:: minimum length
#maxLength:: maximum length
#Returns:: G_Variables
#Example:: example name
               #When I set variable "Customer_info" to a random numeric string of minimum length "2" and maximum length "7"         
#End_DOC
Given(/^I set variable "([^"]*)" to a random numeric string of minimum length "([^"]*)" and maximum length "([^"]*)"$/) do |newVariable, minLength, maxLength|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  G_Variables.setVariable(newVariable, Random.rand(minLength.to_i**maxLength.to_i).to_s)
end

#Start_DOC
#Author:: Unknown
#Desc:: Get value from variable
#variable:: variable name
#Returns:: G_Variables
#Example:: example name
               #When I log variable "Customer_info"   
#End_DOC
Given(/^I log variable "([^"]*)"$/) do |variable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  puts G_Variables.getVariable(variable)
end

#Start_DOC
#Author:: Unknown
#Desc:: log variable with variableLocation
#variable:: variable name
#variableLocation:: defined the variable location
#Returns:: G_Variables
#Example:: example name
               #When I log variable "Customer_info" at "0\information"  
#End_DOC
Given(/^I log variable "([^"]*)" at "([^"]*)"$/) do |variable, variableLocation|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  puts G_Variables.getVariable(variable, variableLocation)
end

#Start_DOC
#Author:: Unknown
#Desc:: Variable operator
#variable:: variable name
#operator:: operator (tostring|upcasing|downcasing|capitalizing|abs)
#Returns:: G_Variables
#Example:: example name
               #When I manipulate variable "Customer_info" by "tostring"
#End_DOC
Given(/^I manipulate variable "([^"]*)" by (tostring|upcasing|downcasing|capitalizing|abs)$/) do |variable, operator|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  G_Variables.operateVariable(variable, operator)
end

#Start_DOC
#Author:: Unknown
#Desc:: special Variable operator
#variable:: variable name
#variableLocation:: defined the variable location
#operator:: operator (tostring|upcasing|downcasing|capitalizing|abs)
#Returns:: G_Variables
#Example:: example name
               #When I manipulate variable "Customer_info" at "0\information" by "tostring"
#End_DOC
Given(/^I manipulate variable "([^"]*)" at "([^"]*)" by (tostring|upcasing|downcasing|capitalizing|abs)$/) do |variable, variableLocation, operator|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  G_Variables.operateVariable(variable, operator, {:location=>variableLocation})
end

#Start_DOC
#Author:: Unknown
#Desc:: Variable operator value needed
#variable:: variable name
#operator:: operator (adding|subtracting|multiplying|dividing)
#modifier:: value for the operator
#Returns:: G_Variables
#Example:: example name
               #When I manipulate variable "Customer_info" by "adding" with "s"
#End_DOC
Given(/^I manipulate variable "([^"]*)" by (adding|subtracting|multiplying|dividing) with "([^"]*)"$/) do |variable, operator, modifier|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  G_Variables.operateVariable(variable, operator, {:value=>modifier})
end

#Start_DOC
#Author:: Unknown
#Desc:: special Variable operator value needed
#variable:: variable name
#variableLocation:: defined the variable location
#operator:: operator (tostring|upcasing|downcasing|capitalizing|abs)
#modifier:: value for the operator
#Returns:: G_Variables
#Example:: example name
               #When I manipulate variable "Customer_info" at "0\information" by "adding" with "s"
#End_DOC
Given(/^I manipulate variable "([^"]*)" at "([^"]*)" by (adding|subtracting|multiplying|dividing) with "([^"]*)"$/) do |variable, variableLocation, operator, modifier|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  G_Variables.operateVariable(variable, operator, {:location=>variableLocation, :value=>modifier})
end

#Start_DOC
#Author:: 
#Desc:: take a flat variable and replace the pattern with string or value from a variable or variable hash with matching key
#variable:: variable name
#findFromVariable:: the element from variable will be replace
#option:: option (string|variable)
#replacement:: replacement for variable
#Returns:: G_Variables
#Example:: example name
               #When I manipulate variable "Customer_info" by replacing pattern "s" with "string" "a"
#End_DOC
Given(/^I manipulate variable "([^"]*)" by replacing pattern "([^"]*)" with (string|variable) "([^"]*)"$/) do |variable, findFromVariable, option, replacement|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  case (option)
    when "string"
      G_Variables.setVariable(variable, G_Variables.getVariable(variable).gsub(/#{findFromVariable}/, replacement))
    when "variable"
      G_Variables.setVariable(variable, G_Variables.getVariable(variable).gsub(/#{findFromVariable}/, G_Variables.getVariable(replacement)))
  end    
  #puts "Variable = " + G_Variables.getVariable(variable)
end

#Start_DOC
#Author:: Unknown
#Desc:: Move values from one node to another in Variable Model
#newVariable:: new variable name
#orignalVariable:: existing variable name
#keyVariable:: the variable has key value
#Returns:: G_Variables
#Example:: example name
               #When I set variable "Customer_info" from variable "Customer_record" using key in variable "Customer_variable"
#End_DOC
Given(/^I set variable "([^"]*)" from variable "([^"]*)" using key in variable "([^"]*)"$/) do |newVariable, orignalVariable, keyVariable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  G_Variables.setVariable(newVariable, G_Variables.getVariable(orignalVariable, G_Variables.getVariable(keyVariable)))
end

#Start_DOC
#Author:: Unknown
#Desc:: Move values from one node to another in Variable Model at variable location 
#newVariable:: new variable name
#orignalVariable:: existing variable name
#keyVariable:: the variable has key value
#keyVariableLocation:: defined the variable location
#Returns:: G_Variables
#Example:: example name
               #When I set variable "Customer_info" from variable "Customer_record" using key in variable "Customer_variable" at location "0\information"
#End_DOC
Given(/^I set variable "([^"]*)" from variable "([^"]*)" using key in variable "([^"]*)" at location "([^"]*)"$/) do |newVariable, orignalVariable, keyVariable, keyVariableLocation|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  G_Variables.setVariable(newVariable, G_Variables.getVariable(orignalVariable, G_Variables.getVariable(keyVariable, keyVariableLocation)))
end

#Start_DOC
#Author:: Unknown
#Desc:: Move Variable to another in Variable Model
#newVariable:: new variable name
#orignalVariable:: existing variable name
#Returns:: G_Variables
#Example:: example name
               #When I set variable "Customer_info" to variable "Customer_record"
#End_DOC
Given(/^I set variable "([^"]*)" to variable "([^"]*)"$/) do |newVariable, orignalVariable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  G_Variables.setVariable(newVariable, G_Variables.getVariable(orignalVariable))
end

#Start_DOC
#Author:: Unknown
#Desc:: Move Variable to another in Variable Model at varible location
#newVariable:: new variable name
#orignalVariable:: existing variable name
#orignalVariableLocation:: defined the orignal variable location
#Returns:: G_Variables
#Example:: example name
               #When I set variable "Customer_info" to variable "Customer_record" at "0\information"
#End_DOC
Given(/^I set variable "([^"]*)" to variable "([^"]*)" at "([^"]*)"$/) do |newVariable, orignalVariable, orignalVariableLocation|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  G_Variables.setVariable(newVariable, G_Variables.getVariable(orignalVariable, orignalVariableLocation))
end

#Start_DOC
#Author:: Unknown
#Desc:: Move Variable to another in Variable Model
#newVariable:: new variable name
#newVariableLocation:: defined the new variable location
#orignalVariable:: existing variable name
#Returns:: G_Variables
#Example:: example name
               #When I set variable "Customer_info" at "0\information" to variable "Customer_record" 
#End_DOC
Given(/^I set variable "([^"]*)" at "([^"]*)" to variable "([^"]*)"$/) do |newVariable, newVariableLocation, orignalVariable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  G_Variables.setVariable(newVariable, G_Variables.getVariable(orignalVariable), newVariableLocation)
end

#Start_DOC
#Author:: Unknown
#Desc:: Move Variable to another in Variable Model at variable location
#newVariable:: new variable name
#newVariableLocation:: defined the new variable location
#orignalVariable:: existing variable name
#orignalVariableLocation:: defined the orignal variable location
#Returns:: G_Variables
#Example:: example name
               #When I set variable "Customer_info" at "0\information" to variable "Customer_record" at "0\information"
#End_DOC
Given(/^I set variable "([^"]*)" at "([^"]*)" to variable "([^"]*)" at "([^"]*)"$/) do |newVariable, newVariableLocation, orignalVariable, orignalVariableLocation|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  G_Variables.setVariable(newVariable, G_Variables.getVariable(orignalVariable, orignalVariableLocation), newVariableLocation)
end

#Start_DOC
#Author:: 
#Desc:: concatenate G_Variables into another variable (Only works for flat level G_Variables.)
#variable1:: variable1 name
#variable2:: variable2 name
#resultVariable:: result variable name
#Returns:: G_Variables
#Example:: example name
               #When I concatenate variable "FisrtName" and variable "LastName" into variable "FullName" 
#End_DOC
When(/^I concatenate variable "([^"]*)" and variable "([^"]*)" into variable "([^"]*)"$/) do |variable1, variable2, resultVariable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  G_Variables.setVariable(resultVariable, G_Variables.getVariable(variable1).to_s + G_Variables.getVariable(variable2).to_s)
  #puts G_Variables.getVariable(var3)
end

#Start_DOC
#Author:: 
#Desc:: concatenate G_Variables into another variable (Only works for flat level G_Variables.)
#variable:: variable name
#value:: values
#resultVariable:: result variable name
#Returns:: G_Variables
#Example:: example name
               #When I concatenate variable "FirstName" and "James" into variable "FullName" 
#End_DOC
When(/^I concatenate variable "([^"]*)" and "([^"]*)" into variable "([^"]*)"$/) do |variable , value, resultVariable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  G_Variables.setVariable(resultVariable, G_Variables.getVariable(variable ).to_s + value.to_s)
  #puts G_Variables.getVariable(var3)
end

#Start_DOC
#Author:: 
#Desc:: concatenate value and variable into another variable (Only works for flat level G_Variables.)
#value:: values
#variable:: variable name
#resultVariable:: result variable name
#Returns:: G_Variables
#Example:: example name
               #When I concatenate "Gordon" and variable "LastName" into variable "FullName" 
#End_DOC
When(/^I concatenate "([^"]*)" and variable "([^"]*)" into variable "([^"]*)"$/) do |value, variable, resultVariable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  G_Variables.setVariable(resultVariable, value.to_s + G_Variables.getVariable(variable).to_s)
  #puts G_Variables.getVariable(var3)
end


#Start_DOC
#Author:: 
#Desc:: get substring of variable and save to another variable (Only works for flat level G_Variables.)
#variable:: variable name
#startIndex:: start index
#endIndex:: end index
#resultVariable:: result variable name
#Returns:: G_Variables
#Example:: example name
               #When I get substring of variable "vname" from "0" to "3" into variable "new_varname" 
#End_DOC
When(/^I get substring of variable "([^"]*)" from "([^"]*)" to "([^"]*)" into variable "([^"]*)"$/) do |variable,startIndex,endIndex,resultVariable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  value = G_Variables.getVariable(variable)
  if endIndex == "end"
    endIndex = value.to_s.length
  end
  G_Variables.setVariable(resultVariable, value.to_s[startIndex.to_i..endIndex.to_i])
  #puts G_Variables.getVariable(var3)
end

#Start_DOC
#Author:: 
#Desc:: convert BigDecimal to string in a float or int format
#variable:: variable name
#toType:: the format type to convert to
#resultVariable:: result variable name
#Returns:: G_Variables
#Example:: example name
               #Then I convert variable "TransactionAmount" from BigDecimal to "float_2" into variable "TransactionAmount"
#End_DOC
When(/^I convert variable "([^"]*)" from BigDecimal to "(float_\d+|int_\d+)" into variable "([^"]*)"$/) do |variable, toType, resultVariable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  
  value = G_Variables.getVariable(variable)
  if toType.match(/^float_/) 
    formatedValue =  sprintf("%.#{toType[/\d+/]}f",value.to_f)
  else toType.match(/^int_/) 
    formatedValue =  sprintf("%.#{toType[/\d+/]}d",value.to_i)
  end
  
  if value.class == BigDecimal
    G_Variables.setVariable(resultVariable, formatedValue)
  else
    value.class.should eq(BigDecimal)
  end
end

#Start_DOC
#Author:: 
#Desc:: get last word of variable and save to another variable (Only works for flat level G_Variables.)
#variable:: variable name
#startIndex:: start index
#endIndex:: end index
#resultVariable:: result variable name
#Returns:: G_Variables
#Example:: example name
               #When I get last word of variable "vname" from "0" to "3" into variable "new_varname" 
#End_DOC
When(/^I get (first|last) word of variable "([^"]*)" into variable "([^"]*)"$/) do |position,variable,resultVariable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  words = G_Variables.getVariable(variable).to_s.split(' ')
  if(words.length > 0)
    if(position.downcase == "first")
      G_Variables.setVariable(resultVariable, words[0].sub("?", ""))
    else
      G_Variables.setVariable(resultVariable, words[words.length-1].sub("?", "").sub(".",""))
    end
  else
    G_Variables.setVariable(resultVariable, "")
  end
  #puts G_Variables.getVariable(var3)
end

#Start_DOC
#Author:: Unknown
#Desc:: variable Comparison with value
#params:: 
#variable:: variable name
#operator:: operator (==|gt|!=|gte|contains|in)
#value:: values
#Returns:: True or False
#Example:: example name
               #When Variable "customerKey" == "1234567"        
#End_DOC
Then(/^Variable "([^"]*)" (==|>|!=|>=|<|<=|=~|contains|doesnotcontain|in|notin) "([^"]*)"$/) do |variable, operator, value|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  description = "Variable #{variable} #{operator} #{value}"
  G_Variables.assert().assert(description, G_Variables.getVariable(variable), value, operator)
end

#Start_DOC
#Author:: Unknown
#Desc:: variable Comparison with case insensitive
#params:: 
#variable:: variable name
#operator:: operator (==|gt|!=|gte|contains|in)
#value:: values
#Returns:: True or False
#Example:: example name
               #When Variable "customerKey" == "1234567" with case insensitive      
#End_DOC
Then(/^Variable "([^"]*)" (==|>|!=|>=|<|<=|=~|contains|doesnotcontain|in|notin) "([^"]*)" with case insensitive$/) do |variable, operator, value|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  description = "Variable #{variable} #{operator} #{value} with case insensitive"
  G_Variables.assert().assert(description, G_Variables.getVariable(variable).to_s.upcase, value.to_s.upcase, operator)
end

#Start_DOC
#Author:: Unknown
#Desc:: variable Comparison with ignore whitespaces in the leading and trailing whitespace
#params:: 
#variable:: variable name
#operator:: operator (==|gt|!=|gte|contains|in)
#value:: values
#Returns:: True or False
#Example:: example name
               #When Variable "customerKey" == "1234567 " with whitespace insensitive      
#End_DOC
Then(/^Variable "([^"]*)" (==|>|!=|>=|<|<=|=~|contains|doesnotcontain|in|notin) "([^"]*)" with whitespace insensitive$/) do |variable, operator, value|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  description = "Variable #{variable} #{operator} #{value} with whitespace insensitive"
  G_Variables.assert().assert(description, G_Variables.getVariable(variable).to_s.strip, value.to_s.strip, operator)
end

#Start_DOC
#Author:: Unknown
#Desc:: special variable Comparison
#params:: 
#variable:: variable name
#variableLocation:: defined the variable location
#operator:: operator (==|>|!=|>=|=~|contains|doesnotcontain|in|notin)
#value:: values
#Returns:: True or False
#Example:: example name
               #When Variable "customer_record" at "0\customerKey"  == "1234567"      
#End_DOC
Then(/^Variable "([^"]*)" at "([^"]*)" (==|>|!=|>=|<|<=|=~|contains|doesnotcontain|in|notin) "([^"]*)"$/) do |variable, variableLocation, operator, value|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
 
 begin
   values = G_Variables.getVariable(variable, variableLocation)
 rescue Exception => e
   puts "getVariable error: #{e}"
   values = nil
 end
 
  description = "Variable #{variable} at #{variableLocation} #{operator} #{value}"  
  G_Variables.assert().assert(description, values, value, operator)

end

#Start_DOC
#Author:: Unknown
#Desc:: special variable Comparison with case insensitive
#params:: 
#variable:: variable name
#variableLocation:: defined the variable location
#operator:: operator (==|>|!=|>=|=~|contains|doesnotcontain|in|notin)
#value:: values
#Returns:: True or False
#Example:: example name
               #When Variable "customer_record" at "0\customerKey"  == "1234567" with case insensitive     
#End_DOC
Then(/^Variable "([^"]*)" at "([^"]*)" (==|>|!=|>=|=~|contains|doesnotcontain|in|notin) "([^"]*)" with case insensitive$/) do |variable, variableLocation, operator, value|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

   begin
     values = G_Variables.getVariable(variable, variableLocation).to_s.upcase
   rescue Exception => e
     puts "getVariable error: #{e}"
     values = nil
   end

  description = "Variable #{variable} at #{variableLocation} #{operator} #{value} with case insensitive"
  G_Variables.assert().assert(description, values, value.to_s.upcase, operator)

end

#Start_DOC
#Author:: Unknown
#Desc:: variable Comparison with ignore whitespaces in the leading and trailing whitespace
#params:: 
#variable:: variable name
#variableLocation:: defined the variable location
#operator:: operator (==|>|!=|>=|=~|contains|doesnotcontain|in|notin)
#value:: values
#Returns:: True or False
#Example:: example name
               #When Variable "customer_record" at "0\customerKey"  == "1234567 " with whitespace insensitive     
#End_DOC
Then(/^Variable "([^"]*)" at "([^"]*)" (==|>|!=|>=|=~|contains|doesnotcontain|in|notin) "([^"]*)" with whitespace insensitive$/) do |variable, variableLocation, operator, value|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

   begin
     values = G_Variables.getVariable(variable, variableLocation)
   rescue Exception => e
     puts "getVariable error: #{e}"
     values = nil
   end

  description = "Variable #{variable} at #{variableLocation} #{operator} #{value} with whitespace insensitive"
  G_Variables.assert().assert(description, values.to_s.strip, value.to_s.strip, operator)

end

#Start_DOC
#Author:: Unknown
#Desc:: different G_Variables Comparison
#params:: 
#variable:: variable name
#operator:: operator (==|>|!=|>=|=~|contains|doesnotcontain|in|notin)
#comparedVariable:: variable name for comparison
#Returns:: True or False
#Example:: example name
               #When Variable "Customer_Record" contains Variable "customerKey"     
#End_DOC
Then(/^Variable "([^"]*)" (==|>|!=|>=|<|<=|=~|contains|doesnotcontain|in|notin) Variable "([^"]*)"$/) do |variable, operator, comparedVariable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  
   begin
     value = G_Variables.getVariable(variable)
   rescue Exception => e
     puts "getVariable error: #{e}"
     value = nil
   end
  
  description = "Variable #{variable} #{operator} Variable #{comparedVariable}"
  G_Variables.assert().assert(description, value, G_Variables.getVariable(comparedVariable), operator)
end

#Start_DOC
#Author:: Unknown
#Desc:: different G_Variables Comparison with case insensitive
#params:: 
#variable:: variable name
#operator:: operator (==|>|!=|>=|=~|contains|doesnotcontain|in|notin)
#comparedVariable:: variable name for comparison
#Returns:: True or False
#Example:: example name
               #When Variable "Customer_Record" contains Variable "customerKey" with case insensitive   
#End_DOC
Then(/^Variable "([^"]*)" (==|>|!=|>=|<|<=|=~|contains|doesnotcontain|in|notin) Variable "([^"]*)" with case insensitive$/) do |variable, operator, comparedVariable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

   begin
     value = G_Variables.getVariable(variable).to_s.upcase
   rescue Exception => e
     puts "getVariable error: #{e}"
     value = nil
   end  
  
  description = "Variable #{variable} #{operator} Variable #{comparedVariable} with case insensitive"
  G_Variables.assert().assert(description, value, G_Variables.getVariable(comparedVariable).to_s.upcase, operator)
end

#Start_DOC
#Author:: Unknown
#Desc:: different special G_Variables Comparison 
#params:: 
#variable:: variable name
#variableLocation:: defined the variable location
#operator:: operator (==|>|!=|>=|=~|contains|doesnotcontain|in|notin)
#comparedVariable:: variable name for comparison
#Returns:: True or False
#Example:: example name
               #When Variable "Customer_Record" at "0\customerKey" == Variable "customerKey" 
#End_DOC
Then(/^Variable "([^"]*)" at "([^"]*)" (==|>|!=|>=|<|<=|=~|contains|doesnotcontain|in|notin) Variable "([^"]*)"$/) do |variable, variableLocation, operator, comparedVariable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

   begin
     value = G_Variables.getVariable(variable, variableLocation)
   rescue Exception => e
     puts "getVariable error: #{e}"
     value = nil
   end
   
  description = "Variable #{variable} at #{variableLocation} #{operator} Variable #{comparedVariable}"
  G_Variables.assert().assert(description, value, G_Variables.getVariable(comparedVariable), operator)
end

#Start_DOC
#Author:: Unknown
#Desc:: different special G_Variables Comparison with case insensitive
#params:: 
#variable:: variable name
#variableLocation:: defined the variable location
#operator:: operator (==|>|!=|>=|=~|contains|doesnotcontain|in|notin)
#comparedVariable:: variable name for comparison
#Returns:: True or False
#Example:: example name
               #When Variable "Customer_Record" at "0\customerKey" == Variable "customerKey" with case insensitive   
#End_DOC
Then(/^Variable "([^"]*)" at "([^"]*)" (==|>|!=|>=|<|<=|=~|contains|doesnotcontain|in|notin) Variable "([^"]*)" with case insensitive$/) do |variable, variableLocation, operator, comparedVariable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

   begin
     value = G_Variables.getVariable(variable, variableLocation).to_s.upcase
   rescue Exception => e
     puts "getVariable error: #{e}"
     value = nil
   end
   
  description = "Variable #{variable} at #{variableLocation} #{operator} Variable #{comparedVariable} with case insensitive"
  G_Variables.assert().assert(description, value, G_Variables.getVariable(comparedVariable).to_s.upcase, operator)
end

#Start_DOC
#Author:: Unknown
#Desc:: different special G_Variables Comparison 
#params:: 
#variable:: variable name
#variableLocation:: defined the variable location
#operator:: operator (==|>|!=|>=|=~|contains|doesnotcontain|in|notin)
#comparedVariable:: variable name for comparison
#comparedVariableLocation:: defined the compared Variable location
#Returns:: True or False
#Example:: example name
               #When Variable "Customer_Record" at "0\customerKey" == Variable "Customer_info" at "0\customerKey"
#End_DOC
Then(/^Variable "([^"]*)" at "([^"]*)" (==|>|!=|>=|<|<=|=~|contains|doesnotcontain|in|notin) Variable "([^"]*)" at "([^"]*)"$/) do |variable, variableLocation, operator, comparedVariable, comparedVariableLocation|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  description = "Variable #{variable} at #{variableLocation} #{operator} Variable #{comparedVariable} at #{comparedVariableLocation}"
  G_Variables.assert().assert(description, G_Variables.getVariable(variable, variableLocation), G_Variables.getVariable(comparedVariable, comparedVariableLocation), operator)
end

#Start_DOC
#Author:: Unknown
#Desc:: different special G_Variables Comparison with case insensitive
#params:: 
#variable:: variable name
#variableLocation:: defined the variable location
#operator:: operator (==|>|!=|>=|=~|contains|doesnotcontain|in|notin)
#comparedVariable:: variable name for comparison
#comparedVariableLocation:: defined the compared Variable location
#Returns:: True or False
#Example:: example name
               #When Variable "Customer_Record" at "0\customerKey" == Variable "Customer_info" at "0\customerKey" with case insensitive
#End_DOC
Then(/^Variable "([^"]*)" at "([^"]*)" (==|>|!=|>=|<|<=|=~|contains|doesnotcontain|in|notin) Variable "([^"]*)" at "([^"]*)" with case insensitive$/) do |variable, variableLocation, operator, comparedVariable, comparedVariableLocation|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  description = "Variable #{variable} at #{variableLocation} #{operator} Variable #{comparedVariable} at #{comparedVariableLocation} with case insensitive"
  G_Variables.assert().assert(description, G_Variables.getVariable(variable, variableLocation).to_s.upcase, G_Variables.getVariable(comparedVariable, comparedVariableLocation).to_s.upcase, operator)
end

#Start_DOC
#Author::
#Desc:: Get a random number in specific range and set it to variable
#params::
#startNbr:: start number 
#endNbr:: end number
#variableName:: the variable name you want to set
#Returns::
#Example::
#Given I get a random number between "1" to "100" and set it to variable "randNbr"
#End_DOC
Given(/^I get a random number between "([^"]*)" to "([^"]*)" and set it to variable "([^"]*)"$/) do |startNbr, endNbr, variableName|
    
    rand = Random.new
    G_Variables.setVariable(variableName.to_s,rand(startNbr.to_i..endNbr.to_i).to_s)
end

#Start_DOC
#Author::
#Desc:: Get random number or string or char with specific length and set it to variable
#params::
#charType:: "string" or "number" or "char"(mixed with string and number)
#length:: length of the char you want to get
#variableName:: the variable name you want to set
#Returns::
#Example::
#Given I get a random number with length "8" and set it to variable "randNbr"
#Given I get a random string with length "8" and set it to variable "randString"
#Given I get a random char with length "8" and set it to variable "randChar"
#End_DOC
Given(/^I get a random (number|string|char) with length "([^"]*)" and set it to variable "([^"]*)"$/) do |charType, length, variableName|
        
#      G_Variables.setVariable(variableName.to_s,Util.getRandCharWithLength(charType.to_s.downcase ,length.to_i).to_s)            
end

#==========================Verify Steps===========================================================
