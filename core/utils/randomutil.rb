# encoding=utf-8
#Author: Stephen Zhang

module RandomizeUtil
  def self.getRandCharWithLength(charType,length)
   if charType.to_s.downcase != "string" && charType.to_s.downcase != "number" && charType.to_s.downcase != "char"
     raise "charType must be string or number or char!"
   end
   case charType.to_s.downcase
     
   when "string"
   value =  length.to_i.times.map { [*'A'..'Z', *'a'..'z'].sample }.join
   when "number"
   value =  length.to_i.times.map { [*'0'..'9'].sample }.join   
   when "char"
   value =  length.to_i.times.map { [*'A'..'Z', *'a'..'z', *'0'..'9'].sample }.join
   end   
   return value    
  end
   
end
