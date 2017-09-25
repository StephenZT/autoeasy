require 'time'
require File.expand_path(File.dirname(__FILE__)) + "/Logger.rb"

module AutoEasy
  module Core
    class AssertError < StandardError; end
    class AssertArgumentError < StandardError; end
    
    class Assert
    	@debug = false
    	#If true will store error into LoggerTrace.LogTrack instead of raise error, so that we can continue test 
    	@soft_assert = false

      def initialize(opts={})
        if opts.key?(:debug)
          @debug = opts[:debug]
        end
        if opts.key?(:soft_assert)
          @soft_assert = opts[:soft_assert]
        end
      end
    	
    	def assert(*args)
    		if(@debug && args.length > 1) then
    			STDOUT.puts "description: " + args[0]
    			STDOUT.puts "argument 1: " + (args[1] === "" || args[1] === nil ? "Empty" : args[1].to_s)
    			if(args.length == 4) then
    				STDOUT.puts "argument 2: " + args[2]
    				STDOUT.puts "operation: " + args[3]
    			end
    		end
    		if args.length == 4 then
    			assertComparison(args[0], args[1], args[2], args[3])
    		elsif args.length == 2
    			assertBoolean(args[0], args[1])
    		else
    			raise AssertArgumentError.new("Can't assert on argument length " + args.length.to_s)
    		end
    
    	end
    
    	def warn(*args)
    		if(@debug && args.length > 1) then
    			STDOUT.puts "description: " + args[0]
    			STDOUT.puts "argument 1: " + (args[1] === "" || args[1] === nil ? "Empty" : args[1].to_s)
    			if(args.length == 4) then
    				STDOUT.puts "argument 2: " + args[2]
    				STDOUT.puts "operation: " + args[3]
    			end
    		end
    		if args.length == 4 then
    			warnComparison(args[0], args[1], args[2], args[3])
    		elsif args.length == 2
    			warnBoolean(args[0], args[1])
    		else
    			raise AssertArgumentError.new("Can't warn on argument length " + args.length.to_s)
    		end
    	end
    
    	private
    
    	def assertComparison(description, leftValue, rightValue, operation)
    		@operation = operation
    		boolean = compare(leftValue, rightValue)
    		expected = " Expected:: [" + leftValue.to_s + "] " + @operation + " [" + rightValue.to_s + "]"
    		
    		if(!boolean) then
    		  LoggerTrace.LogTrack(description + " (" + expected + ") ",LoggerTrace::LogLevel::Error)
    		end
    		assertBoolean(description, boolean, expected)
    		return boolean
    	end
    
    	def assertBoolean(description, boolean, expected = " Expected true but was false")
    		if(!boolean)
    		  if(@soft_assert)
    		    puts "Soft Failed:: " + description + expected
    		  else
    		    raise AssertError.new("Failed:: " + description + expected) 
    		  end
    		else
    		  STDOUT.puts "Passed:: " + description
    		end
    		return boolean
    	end
    
    	def warnComparison(description, leftValue, rightValue, operation)
    		@operation = operation
    		boolean = compare(leftValue, rightValue)
    		expected = " Expected:: [" + leftValue.to_s + "] " + @operation + " [" + rightValue.to_s + "]"
    		if(!boolean) then
          LoggerTrace.LogTrack(description + " (" + expected + ") ", LoggerTrace::LogLevel::Warning)
        end
    		warnBoolean(description, boolean, expected)
    		return boolean
    	end
    
    	def warnBoolean(description, boolean, expected = " Expected true but was false")
    		if(!boolean) then
    			STDOUT.puts "Failed:: " + description + expected
    		else
    			STDOUT.puts "Passed:: " + description
    		end
    		return boolean
    	end
    
    	def compare(leftValue, rightValue)
    		comparison = false
    		converted = false
    
    		# if it's for regular expression, all value should be string
        if (@operation == "match" || @operation == "=~" || @operation == "contains" || @operation == "doesnotcontain" || @operation == "in" || @operation == "notin")
          leftValue = leftValue.to_s
      	  rightValue = rightValue.to_s
        # If If either left or right value is a bigdecimal type, convert to bigdecimal for cmoparison 
      	elsif leftValue =~ /\d+E\d+/  || leftValue =~ /\d+E\d+/
      	  leftValue = BigDecimal.new(leftValue)
          rightValue = BigDecimal.new(rightValue)
      	# If either left or right value is a Time object, then we need to convert any string value to Time for cmoparison    
      	elsif leftValue.is_a?(Time) || rightValue.is_a?(Time)
      		leftValue = leftValue.is_a?(String) ? Time.parse(leftValue) : leftValue
      		rightValue = rightValue.is_a?(String) ? Time.parse(rightValue) : rightValue
      	# Anything that has any non-digit or more than one decimal is converted to string 	
      	elsif (leftValue =~ /[^[:digit:]\.]/ || (leftValue.to_s.count ".") > 1) || (rightValue =~ /[^[:digit:]\.]/ || (rightValue.to_s.count ".") > 1)
      		leftValue = leftValue.to_s
      	  rightValue = rightValue.to_s
    
        else
        	begin
            if((leftValue.to_s.scan(".") || rightValue.to_s.scan(".")) && (leftValue.to_f != 0.0 || leftValue == "0" || leftValue == 0.0 || leftValue == 0 || leftValue == "0.0") && (rightValue.to_f != 0.0 || rightValue == 0.0 || rightValue == 0 || rightValue == "0" || rightValue == "0.0"))
                  leftValue = leftValue.to_f
              	rightValue = rightValue.to_f
              	converted = true
          	end
        	rescue
        	  #Nothind required here
        	end
    
        	if !converted
          	begin
            	if((leftValue.to_i != 0 || leftValue == "0" || leftValue == 0) && (rightValue.to_i != 0 || rightValue == "0" || rightValue == 0))
              	leftValue = leftValue.to_i
              	rightValue = rightValue.to_i
             		converted = true
            	end
          	rescue  
          	  #Nothing reruied here
          	end
        	end
    
        	if !converted
          	leftValue = leftValue.to_s
          	rightValue = rightValue.to_s
        	end
    		end
    
    		begin
  		    case(@operation)
  				when "equals", "=", "=="
  					@operation = "=="
  					comparison = leftValue == rightValue
  				when "doesnotequals", "!="
  					@operation = "!="
  					comparison = leftValue != rightValue
  				when "gt", ">"
  					@operation = ">"
  					comparison = leftValue > rightValue
  				when "gte", ">="
  					@operation = ">="
  					comparison = leftValue >= rightValue
  				when "lt", "<"
  					@operation = "<"
  					comparison = leftValue < rightValue
  				when "lte", "<="
  					@operation = "<="
  					comparison = leftValue <= rightValue
  				when "match", "=~"
            @operation = "=~"
            comparison = leftValue =~ /#{rightValue}/
          when "doesnotmatch", "!=~"
            @operation = "!=~"
            comparison = !(leftValue =~ /#{rightValue}/)
  				when "contains"
  					comparison = leftValue.include? rightValue
  				when "in"
  					comparison = rightValue.include? leftValue
  				when "doesnotcontain"
  					comparison = !(leftValue.include? rightValue)
  				when "notin"
  					comparison = !(rightValue.include? leftValue)
    			end
    		rescue Exception => msg
    			STDOUT.puts msg
    		end
    		return comparison
    	end
    end
  end
end


