# encoding=utf-8

#Start_DOC
#Author:: 
#Desc:: save the query result as reponse value without parameters
#params:: 
#queryName:: query Name from Database Queries
#responseName:: name of the query result list
#Returns:: responseName
#Example:: example name
               #Then I save query "Customer" as "Customer_Record"              
#End_DOC
When(/^I save query "([^"]*)" as "([^"]*)"$/) do |queryName, responseName|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  
end

#Start_DOC
#Author:: 
#Desc:: save the query result as reponse using environment variable
#params:: 
#queryName:: query Name from Database Queries
#environment:: query running environment
#responseName:: name of the query result list
#Returns:: responseName
#Example:: example name
               #Then I save query "customer_by_customerkey" using database "QA4" as "Customer_Record"            
#End_DOC
When(/^I save query "([^"]*)" using database "([^"]*)" as "([^"]*)"$/) do |queryName, databaseName, responseName|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
end

#Start_DOC
#Author:: Unknown
#Desc:: save the query result as reponse using parameters
#params:: 
#queryName:: query Name from Database Queries
#parameter:: the parameter for query conditions
#responseName:: name of the query result list
#Returns:: responseName
#Example:: example name
               #Then I save query "customer_by_customerkey" with parameters "CustomerKey=121254654" as "Customer_Record"            
#End_DOC
When(/^I save query "([^"]*)" with parameters "([^"]*)" as "([^"]*)"$/) do |queryName, parameter, responseName|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
end

#Start_DOC
#Author:: Unknown
#Desc:: save the query result as reponse using parameters　and environment
#params:: 
#queryName:: query Name from Database Queries
#environment:: query running environment
#parameter:: the parameter for query conditions
#responseName:: name of the query result list
#Returns:: responseName
#Example:: example name
               #Then I save query "customer_by_customerkey" using database "QA4"　with parameters "customerKey=454654" as "Customer_Record"            
#End_DOC
When(/^I save query "([^"]*)" using database "([^"]*)" with parameters "([^"]*)" as "([^"]*)"$/) do |queryName, environment, parameter, responseName|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
end

#Start_DOC
#Author:: Unknown
#Desc:: save query with variable (Interact with DB Model no DB Specified)
#queryName:: query Name from Database Queries 
#variable:: variable name
#responseName:: name of the query result list
#Returns:: responseName
#Example:: example name
               #When I save query "customer_by_customerkey" with variable "customerKey" as "Customer_Record"   
#End_DOC
When(/^I save query "([^"]*)" with variable "([^"]*)" as "([^"]*)"$/) do |queryName, variable, responseName|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
end

#Start_DOC
#Author:: Unknown
#Desc:: save query with multiple variables (Interact with DB Model no DB Specified)
#queryName:: query Name from Database Queries 
#variables:: variables name
#responseName:: name of the query result list
#Returns:: responseName
#Example:: example name
               #Then I save query "consumerprofile" with multiple variables "accountkey,consumerProfileKeys" as "consumerprofile_record"   
#End_DOC
When(/^I save query "([^"]*)" with multiple variables "([^"]*)" as "([^"]*)"$/) do |queryName, variables, responseName|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  vars=variables.split(',')
  parameters = nil
  vars.each do |k|
    if(parameters == nil)
      parameters = Variables.getParameterString(k, '', :includeKey => true)
    else
      parameters = parameters + "," + Variables.getParameterString(k, '', :includeKey => true)
    end
  end  
  steps %Q{Given I save query "#{queryName}" with parameters "#{parameters}" as "#{responseName}"}
end

#Start_DOC
#Author:: Unknown
#Desc:: save query with variable at variable location
#queryName:: query Name from Database Queries 
#variable:: variable name
#variableLocation:: defined the variable location
#responseName:: name of the query result list
#Returns:: responseName
#Example:: example name
               #Then I save query "customer_by_customerkey" with variable "customerKey" at "0\customerKey" as "Customer_Record"    
#End_DOC
When(/^I save query "([^"]*)" with variable "([^"]*)" at "([^"]*)" as "([^"]*)"$/) do |queryName, variable, variableLocation, responseName|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  parameters = G_Variables.getParameterString(variable, variableLocation, :includeKey => true)
  steps %Q{Given I save query "#{queryName}" with parameters "#{parameters}" as "#{responseName}"}
end

#Start_DOC
#Author:: Unknown
#Desc:: save query with parameters and variables 
#queryName:: query Name from Database Queries
#parameters:: parameters name 
#variable:: variable name
#responseName:: name of the query result list
#Returns:: responseName
#Example:: example name
               #Then I save query "customer_by_customerkey" with parameters "accountkey" and variable "customerKey" as "Customer_Record"    
#End_DOC
When(/^I save query "([^"]*)" with parameters "([^"]*)" and variable "([^"]*)" as "([^"]*)"$/) do |queryName, parameters, variable, responseName|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

#  retrievedParameters = G_Variables.getParameterString(variable, '', :includeKey => true)
  steps %Q{Given I save query "#{queryName}" with parameters "#{parameters},#{retrievedParameters}" as "#{responseName}"}
end

#Start_DOC
#Author:: Unknown
#Desc:: save query with parameters and special　variables 
#queryName:: query Name from Database Queries
#parameters:: parameters name 
#variable:: variable name
#variableLocation:: defined the variable location
#responseName:: name of the query result list
#Returns:: responseName
#Example:: example name
               #Then I save query "customer_by_customerkey" with parameters "accountkey" and variable "customerKey" at "0\customerKey" as "Customer_Record"    
#End_DOC
When(/^I save query "([^"]*)" with parameters "([^"]*)" and variable "([^"]*)" at "([^"]*)" as "([^"]*)"$/) do |queryName, parameters, variable, variableLocation, responseName|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

#  retrievedParameters = G_Variables.getParameterString(variable, variableLocation, :includeKey => true)
  steps %Q{Given I save query "#{queryName}" with parameters "#{parameters},#{retrievedParameters}" as "#{responseName}"}
end

#Start_DOC
#Author:: Unknown
#Desc:: save query with variables in special environment (Interact with DB Model DB Specified)
#queryName:: query Name from Database Queries
#environment:: environment 
#variable:: variable name
#responseName:: name of the query result list
#Returns:: responseName
#Example:: example name
         #Then I save query "customer_by_customerkey" using database "QA4" with variable "customerKey" as "Customer_Record"    
#End_DOC
When(/^I save query "([^"]*)" using database "([^"]*)" with variable "([^"]*)" as "([^"]*)"$/) do |queryName, environment, variable, responseName|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
  parameters = G_Variables.getParameterString(variable,'', :includeKey => true)
  steps %Q{Given I save query "#{queryName}" using database "#{environment}" with parameters "#{parameters}" as "#{responseName}"}
end

#Start_DOC
#Author:: Unknown
#Desc:: save query with special variables in special environment (Interact with DB Model DB Specified)
#queryName:: query Name from Database Queries
#environment:: environment 
#variable:: variable name
#variableLocation:: defined the variable location
#responseName:: name of the query result list
#Returns:: responseName
#Example:: example name
         #Then I save query "customer_by_customerkey" using database "QA4" with variable "customerKey" at "0\customerKey" as "Customer_Record"    
#End_DOC
When(/^I save query "([^"]*)" using database "([^"]*)" with variable "([^"]*)" at "([^"]*)" as "([^"]*)"$/) do |queryName, environment, variable, variableLocation, responseName|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

#  parameters = G_Variables.getParameterString(variable, variableLocation, :includeKey => true)
  steps %Q{Given I save query "#{queryName}" using database "#{environment}" with parameters "#{parameters}" as "#{responseName}"}
end

#Start_DOC
#Author:: Unknown
#Desc:: save query with parameters and variables in special environment (Interact with DB Model DB Specified)
#queryName:: query Name from Database Queries
#environment:: environment
#parameters:: parameters name  
#variable:: variable name
#responseName:: name of the query result list
#Returns:: responseName
#Example:: example name
         #Then I save query "customer_by_customerkey" using database "QA4" with parameters "accountkey" and variable "customerKey" as "Customer_Record"    
#End_DOC
When(/^I save query "([^"]*)" using database "([^"]*)" with parameters "([^"]*)" and variable "([^"]*)" as "([^"]*)"$/) do |queryName, environment, parameters, variable, responseName|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()


#  retrievedParameters = G_Variables.getParameterString(variable,'', :includeKey => true)
  steps %Q{Given I save query "#{queryName}" using database "#{environment}" with parameters "#{parameters},#{retrievedParameters}" as "#{responseName}"}
end

#Start_DOC
#Author:: Unknown
#Desc:: save query with parameters and special variables in special environment (Interact with DB Model DB Specified)
#queryName:: query Name from Database Queries
#environment:: environment
#parameters:: parameters name  
#variable:: variable name
#variableLocation:: defined the variable location
#responseName:: name of the query result list
#Returns:: responseName
#Example:: example name
         #Then I save query "customer_by_customerkey" using database "QA4" with parameters "accountkey" and variable "customerKey" at "0\customerKey" as "Customer_Record"    
#End_DOC
When(/^I save query "([^"]*)" using database "([^"]*)" with parameters "([^"]*)" and variable "([^"]*)" at "([^"]*)" as "([^"]*)"$/) do |queryName, environment, parameters, variable, variableLocation, responseName|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

#  retrievedParameters = G_Variables.getParameterString(variable, variableLocation, :includeKey => true)
  steps %Q{Given I save query "#{queryName}" using database "#{environment}" with parameters "#{parameters},#{retrievedParameters}" as "#{responseName}"}
end

#Start_DOC
#Author:: Unknown
#Desc:: save the first row of query result as variable
#params:: 
#responseName:: name of the query result list
#variable:: first row of the query result
#Returns:: variables
#Example:: example name
               #Then I save first row of response "Customer_Record" as variable "Customer_variable"        
#End_DOC
Then(/^I save first row of response "([^"]*)" as variable "([^"]*)"$/) do |responseName, variable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
end

#Start_DOC
#Author:: Unknown
#Desc:: save the first row of query result by column as variable
#params:: 
#columnName:: column Name from the table
#columnValue:: column value in the table
#responseName:: name of the query result list
#variable:: first row and special column of the query result
#Returns:: variables
#Example:: example name
               #When I save first row where column "customerKey" equals "145１３４" in response "Customer_Record" as variable "Customer_variable"        
#End_DOC
Then(/^I save first row where column "([^"]*)" equals "([^"]*)" in response "([^"]*)" as variable "([^"]*)"$/) do |columnName, columnValue, responseName, variable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
end

#Start_DOC
#Author:: Unknown
#Desc:: Save the first row of query result by column equals variable and set result as variable
#params:: 
#columnName:: column Name from the table
#columnVariableAsValue:: column value from the variable
#responseName:: name of the query result list
#variable::　first row and special column of the query result
#Returns:: variables
#Example:: example name
               #Given I set variable "customerKey" to variable "customer_record" at "0\CustomerKey"
               #When I save first row where column "CUSTOMERKEY" equals "customerKey" in response "Customer_Record" as variable "Customer_variable"       
#End_DOC
Then(/^I save first row where column "([^"]*)" equals variable "([^"]*)" in response "([^"]*)" as variable "([^"]*)"$/) do |columnName, columnVariableAsValue, responseName, variable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

  variableAsValue = G_Variables.getVariable(columnVariableAsValue)
end

#Start_DOC
#Author:: Unknown
#Desc:: save rows of query result by column as variable
#params:: 
#columnName:: column Name from the table
#columnValue:: column value from the table
#responseName:: name of the query result list
#variable:: rows and special column of the query result
#Returns:: variables
#Example:: example name
               #When I save rows where column "CUSTOMERKEY" equals "4423545" in response "Customer_Record" as variable "Customer_variable"               
#End_DOC
Then(/^I save rows where column "([^"]*)" equals "([^"]*)" in response "([^"]*)" as variable "([^"]*)"$/) do |columnName, columnValue, responseName, variable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

end

#Start_DOC
#Author:: Unknown
#Desc:: save rows of query result by column as variable
#params:: 
#columnName:: column Name from the table
#columnValue:: column value from the table
#responseName:: name of the query result list
#variable:: rows and special column of the query result
#Returns:: variables
#Example:: example name
               #When I save rows where column "CUSTOMERKEY" does not equal "4423545" in response "Customer_Record" as variable "Customer_variable"               
#End_DOC
Then(/^I save rows where column "([^"]*)" does not equal "([^"]*)" in response "([^"]*)" as variable "([^"]*)"$/) do |columnName, columnValue, responseName, variable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
end



#Start_DOC
#Author:: Unknown
#Desc:: save value by where conditions and mark it as variable
#params:: 
#columnNameKey:: column Name of the save value
#columnName:: column Name of the where condition
#columnValue:: column value of the where condition
#responseName:: name of the query result list
#variable:: values of the query result
#Returns:: variables
#Example:: example name
               #When I save value of column "ACCOUNTKEY" where column "CUSTOMERKEY" equals "4423545" in response "Customer_Record" as variable "Customer_variable"               
#End_DOC
Then(/^I save value of column "([^"]*)" where column "([^"]*)" equals "([^"]*)" in response "([^"]*)" as variable "([^"]*)"$/) do |columnNameKey,columnName, columnValue, responseName, variable|
 (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
end

#Start_DOC
#Author:: Unknown
#Desc:: save value by where conditions and mark it as variable
#params:: 
#columnNameKey:: column Name of the save value
#columnName:: column Name of the where condition
#columnVariableAsValue:: column variable as value of the where condition 
#responseName:: name of the query result list
#variable:: values of the query result
#Returns:: variables
#Example:: example name
         #Given I set variable "customerKey" to variable "customer_record" at "0\CustomerKey"
               #When I save value of column "ACCOUNTKEY" where column "CUSTOMERKEY" equals variable "customerKey" in response "Customer_Record" as variable "Customer_variable"               
#End_DOC
Then(/^I save value of column "([^"]*)" where column "([^"]*)" equals variable "([^"]*)" in response "([^"]*)" as variable "([^"]*)"$/) do |columnNameKey, columnName, columnValue, responseName, variable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
end

#Start_DOC
#Author:: Unknown
#Desc:: save value by row conditions and mark it as variable
#params:: 
#columnName:: column Name of the table
#rowNumber:: row number of the query result
#responseName:: name of the query result list
#variable:: values of the query result
#Returns:: variables
#Example:: example name
               #When I save value of column "CUSTOMERKEY" at row "2" in response "Customer_Record" as variable "Customer_variable"               
#End_DOC
Then(/^I save value of column "([^"]*)" at row "([^"]*)" in response "([^"]*)" as variable "([^"]*)"$/) do |columnName, rowNumber, responseName, variable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
end

#Start_DOC
#Author:: Unknown
#Desc:: save value by row conditions and mark it as variable
#params:: 
#columnIndex:: column Index of the table
#rowNumber:: row number of the query result
#responseName:: name of the query result list
#variable:: values of the query result
#Returns:: variables
#Example:: example name
               #When I save value of column index "2" at row "2" in response "Customer_Record" as variable "Customer_variable"               
#End_DOC
Then(/^I save value of column index "([^"]*)" at row "([^"]*)" in response "([^"]*)" as variable "([^"]*)"$/) do |columnIndex, rowNumber, responseName, variable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()

end

#Start_DOC
#Author:: Unknown
#Desc:: verify the total number of rows for the query result
#params:: 
#resultRowNumber:: total row number of the query result
#responseName:: name of the query result list
#Returns:: responseName
#Example:: example name
               #When I verify there are "2" rows in the query response "Customer_Record"
#End_DOC
Then(/^I verify there are "([^"]*)" rows in the query response "([^"]*)"$/) do |resultRowNumber, responseName|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()


  if (resultRowNumber.to_s[0,1] == "@")
    resultRowNumber = G_Variables.getVariable(resultRowNumber.split('@')[1])
  end
  
  description = "Query response (#{responseName}) should have #{resultRowNumber} records"
  if resultRowNumber.to_i != 0 || resultRowNumber == "0"
    operator = "=="
  else
    operator = /([^0-9]+)/.match(resultRowNumber)[0]
    resultRowNumber = /([0-9]+)/.match(resultRowNumber)[0]
  end
  begin
  Assert.assert(description, G_Variables.getVariable(responseName).length, resultRowNumber, operator)
  rescue Exception => e
    puts "Assert failed:"
    puts e
  end
end

#Start_DOC
#Author:: Unknown
#Desc:: verify the value in all rows
#params:: 
#resultValue:: the query result list
#columnName:: column Name of the table
#operator:: operator (==|>|!=|>=|=~|contains|doesnotcontain|in|notin)
#textValue:: value of the text
#Returns:: True or False
#Example:: example name
               #When I verify all rows in "Customer_Record" at "CUSTOMERKEY" == "1234567"            
#End_DOC
Then(/^I verify all rows in "([^"]*)" at "([^"]*)" (==|>|!=|>=|=~|contains|doesnotcontain|in|notin) "([^"]*)"$/) do |resultValue, columnName, operator, textValue|
    (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()


  description = "Row count in Variable #{resultValue} at #{columnName} #{operator} #{textValue}"
  G_Variables.getVariable(resultValue).each do |row|
    begin
      Assert.assert(description, row[columnName], textValue, operator)
      rescue Exception => e
      puts "Assert failed:"
      puts e
    end
  end
end

#Start_DOC
#Author:: Unknown
#Desc:: save response as variable (candidates for deprecation)
#params:: 
#responseName:: name of the query result list
#variable:: values of the query result
#Returns:: variables
#Example:: example name
               #When I save response "Customer_Record" as variable "Customer_variable"        
#End_DOC
Then(/^I save response "([^"]*)" as variable "([^"]*)"$/) do |responseName, variable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
end

#Start_DOC
#Author:: Unknown
#Desc:: save response as variable (candidates for deprecation)
#params:: 
#responseName:: name of the query result list
#variable:: values of the query result
#Returns:: variables
#Example:: example name
               #When I save length of response "Customer_Record" as variable "Customer_variable"        
#End_DOC
Then(/^I save length of response "([^"]*)" as variable "([^"]*)"$/) do |responseName, variable|
  (puts 'Ignore this step: skip step marked.'; next) if G_Configuration.getSkipStep()
end


