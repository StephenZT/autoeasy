# encoding=utf-8
#Author: Stephen Zhang

require 'date'

module DateUtil
  def self.getDate()
    return Date.today
  end
  
  def self.dateAdd(days)
    return getDate() + days
  end

  def self.monthAdd(months)
    curMonth = getDate().strftime("%m") # Time.now.strftime("%m")
    if curMonth == "12"
      nexMonth = 1
    elsif curMonth.to_i + months > 12
      nexMonth = (curMonth.to_i + months) % 12 == 0 ? 1:(curMonth.to_i + months) % 12    
    else 
      nexMonth = curMonth.to_i + months
    end
    
    if nexMonth < 10
      nexMonth= "0" +nexMonth.to_s
    end
    return nexMonth
  end


  def self.yearAdd(years)
    curYear = getDate().strftime("%Y") 
    return curYear.to_i + years.to_i  
  end

  def self.formatDate(date, type)
    if date == nil || date.to_s == ""
      raise "Date can not be null."
    end
    
    case(type.to_s)
      when "1","mm/dd/yy"# format date from yyyy/mm/dd to mm/dd/yy
        return DateTime.parse(date.to_s).strftime("%m/%d/%y")
      when "2","yyyy-mm-dd 00:00:00 -0700"# format date from mmddyyyy to yyyy-mm-dd 00:00:00 -0700
        return DateTime.new(date.to_s[4..7].to_i, date.to_s[0..1].to_i, date.to_s[2..3].to_i).strftime("%Y-%m-%d 00:00:00 -0700")
      when "3","mm/dd/yyyy"# format date from (mm/dd/yyyy | yyyy/mm/dd | yyyy-mm-dd | mm-dd-yyyy) to mm/dd/yyyy
        if date.to_s[2] == "/" || date.to_s[2] == "-"
          return DateTime.new(date.to_s[6..9].to_i, date.to_s[0..1].to_i, date.to_s[3..4].to_i).strftime("%m/%d/%Y")
        else
          return DateTime.parse(date.to_s).strftime("%m/%d/%Y")
        end
      when "4","abbrMonth day, yyyy"# format date like Sep 1, 2015
        #return DateTime.new(getDate()).strftime("%b %d, %Y")
        return DateTime.parse("2017-03-26 10:10:10 -0700").strftime("%b %d, %Y")      
      when "5","mmyy"# format date yyyy/mm/dd to mmyy
        return date.to_s[5..6] + date.to_s[2..3] 
      when "6","m/d/yyyy"# format date from yyyy/mm/dd to m/d/yyyy
        return DateTime.parse(date.to_s).strftime("%-m/%-d/%Y")
      when "7","mm/dd/yyyy HH:MM:SS AM/PM"# format date like 06/12/2016 02:28:09 AM
        return DateTime.parse(date.to_s).strftime("%m/%d/%Y %I:%M:%S %p") 
      when "8","yyyy-mm-dd 00:00:00 -0800"# format date from mm/dd/yyyy to yyyy-mm-dd 00:00:00 -0800
        return DateTime.parse(date.to_s).strftime("%Y-%m-%d 00:00:00 -0800")
     end
  end





end


