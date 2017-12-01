# encoding=utf-8
#Author: Stephen Zhang
#Register variables, it will be used anywhere, it's for storing variable cross cucumber statements 
module AutoEasy
  module Core
    class VariableRegister
      include Singleton
    	
      def initialize()
        @Variables = Hash.new
      end
      
    	def getVariable(key, location="")
    		variable = @Variables[key]
    		
    		if(variable == nil) then
    			raise "No variable with key #{key}"
    		end
    		
    		if(location != "") then
    			location.each_line('\\') { 
    				|nestedLocation|
              path = nestedLocation.gsub('\\', '')
              #we cast path to an integer if possible otherwise we get exceptions when attempting to use nested paths that have integers at their base
              if (path.to_i != 0 || path == "0" || path == 0)
              	path = path.to_i
              end
              
              if(path == "" || path == nil)
                  next
              end
                      
              #fix Nested Variable Model can throw exception can't convert String to Integer ----- pd QA-914   
              if(variable.is_a?(NilClass))    
                variable = nil
               elsif(variable.is_a?(Array))
                 variable = variable[path.to_i]
              elsif(!variable.is_a?(Array) && variable[path] == nil)
                variable = variable[path.to_s]
              else
                variable = variable[path]
              end        
    			}
    		end
    		return variable
    	end
    
    	def operateVariable(key, operate, opts={})
    		variable = getVariable(key, opts[:location] == nil ? "" : opts[:location])
    		case(operate)
    		  when "tostring"
    		    variable = variable.to_s
    			when "downcasing"
    				variable = variable.to_s.downcase
    			when "upcasing"
    				variable = variable.to_s.upcase
    			when "capitalizing"
    				variable = variable.to_s
    				variable[0] = variable[0].upcase
    			when "adding", "subtracting", "multiplying", "dividing"
    				variable = castVariable(variable, opts[:value], operate)
    		  when "abs"
    		    if variable.to_s.include?(".")
    		      variable = variable.to_f.abs.to_s
    		    else
    		      variable = variable.to_i.abs.to_s
    		    end
    		  end
    		setVariable(key, variable, opts[:location] == nil ? "" : opts[:location])
    	end
    
    	def castVariable(value, modifier, operation)
    		if((value.to_s.scan(".") || modifier.to_s.scan(".")) && (value.to_f != 0.0 || value == "0" || value == 0.0 || value == 0 || value == "0.0") && (modifier.to_f != 0.0 || modifier == 0.0 || modifier == 0 || modifier == "0" || value == "0.0"))
    			value = value.to_f
    			modifier = modifier.to_f
    		end
    		if((value.to_i != 0 || value == "0" || value == 0) && (modifier.to_i != 0 || modifier == "0" || modifier == 0))
    			value = value.to_i
    			modifier = modifier.to_i
    		else
    			modifier = modifier.to_s
    		end
    		case(operation)
    			when "adding"
    				value += modifier
    			when "subtracting"
    				value -= modifier
    			when "multiplying"
    				value *= modifier
    			when "dividing"
    				value /= modifier if modifier != 0 else raise 'Dividing zero error'
    		end
    		return value
    	end
    
    	def setVariable(key, value, location = "")
    		if(location != "") then
    			currentLocation = ''
    			if(@Variables[key] == nil || !@Variables[key].is_a?(Hash)) then
    				@Variables[key] = Hash.new
    			end		
    			currentVariable = @Variables[key]
    			lastLocation = ''
    			count = 0
    			totalCount = location.scan(/\\/).count
    			if(totalCount > 0) then
    				location.each_line('\\') {
    					|nestedLocation|
    						nestedLocation = nestedLocation.gsub('\\', '')
    						if(nestedLocation == '') then
    							next
    						end
    						count += 1
    						if(totalCount == count) then
    							lastLocation = nestedLocation
    							break
    						end
    						if(currentVariable[nestedLocation] == nil || !currentVariable[nestedLocation].is_a?(Hash)) then				
    							currentVariable[nestedLocation] = Hash.new
    						end
    						currentVariable = currentVariable[nestedLocation]
    				}
    				if(lastLocation == '') then
    					lastLocation = location
    				end
    				if(key == lastLocation) then
    					currentVariable = value
    				else
    					currentVariable[lastLocation] = value
    				end
    			else
    				currentVariable[location] = value
    			end			
    		else
    			@Variables[key] = value
    		end
    	end
    
      def exists(key)
        return @Variables.key?(key)
      end
      
      def assert(opts={})
        return AutoEasy::Core::Assert.new(opts)
      end
      
    end
  end
end

G_Variables ||= AutoEasy::Core::VariableRegister.instance
