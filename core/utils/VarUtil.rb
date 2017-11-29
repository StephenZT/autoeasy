# encoding=utf-8
#Author: Stephen Zhang
#Re-get variable value, if cucumber argument name with '@' 
module VarUtil
  def self.toVaueIfIsVarialbe(varName)
    varValue = varName
    if (varName != nil && varName.to_s[0,1] == "@")
      str = varName.split('@')[1].to_s
      if(str.include?("[") && str.include?("]"))
        varValue = G_Variables.getVariable(str.to_s[0, str.to_s.index("[")], str.to_s[str.to_s.index("[").to_i, (str.to_s.size-1)].gsub("\"", "").gsub("'", "").gsub("[", "").gsub("]", ""))
      else
        if G_Variables.hasVariable(str)
          varValue = G_Variables.getVariable(str)
        else
          warn "The varName: '"+ varName + "' start with @ but we can't find accordingly variable so will treat it as a value."
        end
      end
    end
    return varValue
  end
end