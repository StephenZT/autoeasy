# encoding=utf-8
#Author: Stephen Zhang

module CodeUtil
  def self.convertUnicodeToASCII(non_ascii_string)
    #the unicodes you want to be replaced, you can add more per your demands
    space = "\u2000".force_encoding("UTF-8")
    replacements = { 
      #replace unicode whitespace to ASCII
      space => " ",
    }
    encoding_options = {
      :invalid   => :replace,     # Replace invalid byte sequences
      :replace => "",             # Use a blank for those replacements
      :universal_newline => true, # Always break lines with \n
      # For any character that isn't defined in ASCII, run this
      # code to find out how to replace it
      :fallback => lambda { |char|
        # If no replacement is specified, use an empty string
        replacements.fetch(char, "")
      },
    }
    
    ascii = non_ascii_string.encode(Encoding.find('ASCII'), encoding_options)
    return ascii
  end
end
