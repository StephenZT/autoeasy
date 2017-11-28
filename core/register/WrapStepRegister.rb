# encoding=utf-8
#Author: Stephen Zhang
#Register query script that can be used in whole project
#Examples
require 'singleton'

module AutoEasy
  module Core
    class WrapStepRegister
      include Singleton
      
      def initialize()
        @registered_steps = Hash.new  
      end
      
      #if step include test data (argurment), use this way <<data_name>>
      #exeample  registerWrappedStep("Login",['Given I visit "<<page_name>>" page','When I am on the page "<<page_name>>"])
      def registerWrappedStep(name, steps)
        raise "Wrapped name #{name} already registered." if @registered_steps.key?(name)
        @registered_steps[name.downcase] = steps
      end
      
      def getWrappedStep(name, providerName)
        raise "Wrapped name #{name} does not registered." if !@registered_steps.key?(name.downcase)
        raise "Provider name #{providerName} does not registered." if G_ProviderRegister.getProvider(providerName) == nil
        data = G_ProviderRegister.getProvider(providerName)
        
        steps = @registered_steps[name.downcase]
        real_steps = ""
        
        steps.each do |step|
          var_group = step.scan(/<<([^>>]*)>>/i)
          var_group.each do |varName|
            if (data.getData(varName[0]))
              step = step.gsub('<<' + varName[0] + '>>', data.getData(varName[0]))
            end
          end
          real_steps = real_steps + step + "\n"
        end
        
        return real_steps 
      end
    end
  end
end

G_WrapStepRegister ||= AutoEasy::Core::WrapStepRegister.instance



