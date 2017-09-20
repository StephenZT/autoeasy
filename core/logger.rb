# encoding=utf-8
module LoggerTrace
  module LogLevel          
    Error = 1
    Warning = 2
    Info = 3
    Debug = 4
    
    LevelToS = {1=>'Error ::',2=>'Warning ::',3=>'Info ::',4=>'Debug ::'}
  
    def self.OutputLevel(logLevel)
      return LevelToS.fetch(logLevel,'None ::')
    end

    def self.GetLogLevel(logLevel)
      case(logLevel.to_s.downcase)  
        when "error", 1
          return Error
        when "warning", 2
          return Warning
        when "info", 3
          return Info
        when "debug", 4
          return Debug
      end
    end
  end

  @LogType = LogLevel::Error

  #LoggerTrace methods
  def self.SetLogLevel(logLevel)
    puts logLevel.to_s
    @LogType = LogLevel.GetLogLevel(logLevel)
    
  end

  def self.Log(textToLog, logLevel, logLocation = "")
    if(@LogType.to_i >= logLevel.to_i) then
      if(logLocation == "STDOUT") then
        STDOUT.puts LogLevel.OutputLevel(logLevel).to_s + textToLog.to_s
      else
        puts LogLevel.OutputLevel(logLevel).to_s + textToLog.to_s
      end
    end
  end

  @Logs = Hash.new
 
  def self.LogTrack(textToLog, logLevel)
    if(@Logs[logLevel] == nil ) then 
      @Logs[logLevel] = Array.new
    end 

    @Logs[logLevel].push LogLevel.OutputLevel(logLevel).to_s + textToLog.to_s
  end
  
  def self.Logs
    return @Logs
  end

  def self.GetLogLevel
    return @LogType
  end
  
  def self.assert_no_error_in_log()
    if @Logs.key?(LogLevel::Error) 
      @Logs[LogLevel::Error].each do |errorInfo|
        puts errorInfo
      end
    end
    AutoEasy::Core::Assert.new().assert("Assert no soft failure error in log pool.", @Logs.key?(LogLevel::Error), false, "==")
  end
  
end

