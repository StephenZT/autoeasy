# encoding=utf-8
#Author: Stephen Zhang
#Db result is list of hash struct : [{},{}]
#This class is for get accordingly data from this staruct

module AutoEasy
  module Core
    class NilResultError < StandardError; end
    class InvalidResultError < StandardError; end

    
    class DBResultAction
      attr_reader :result
      
      def initialize(result,opts={})
        raise NilResultError.new("The given result is nil.") if result == nil
        raise InvalidResultError.new("The given result is not array.") if !result.kind_of?(Array)
        result.each do |item|
          raise InvalidResultError.new("The given result details are not hash.") if !item.kind_of?(Hash)
        end
        @result = result   
      end
      
      def size
        @result.length
      end
      
      def get_row_by_index(idx)
        return @result.fetch(idx, nil)
      end
      
      def get_first_row()
        return get_row_by_index(0)  
      end
      
      def get_last_row()
        return get_row_by_index(-1)
      end
      
      def get_rows_meet_condition(condition={})
        @result.select do |data|
            filtered = true
            condition.each do |k,v|
              filtered &= data.key?(k)
              filtered &= data[k] == v
            end
            filtered
        end 
      end
      
      def get_rows_match_condition(condition={})
        @result.select do |data|
            filtered = true
            condition.each do |k,v|
              filtered &= data.key?(k)
              filtered &= data[k].to_s =~ /^#{v.to_s}$/
            end
            filtered
        end 
      end
      
      def get_rows_not_meet_condition(condition={})
        @result.reject do |data|
            filtered = true
            condition.each do |k,v|
              filtered &= data.key?(k)
              filtered &= data[k] == v
            end
            filtered
        end 
      end
      
      def get_rows_not_match_condition(condition={})
        @result.reject do |data|
            filtered = true
            condition.each do |k,v|
              filtered &= data.key?(k)
              filtered &= data[k].to_s =~ /^#{v.to_s}$/
            end
            filtered
        end 
      end
            
    end
  end
end
