# encoding=utf-8

When(/^I execute wrapped steps "([^"]*)" with data provider "([^"]*)"$/) do |wrappedStepName, providerName|
  self_def_steps = G_StepProviderRegister.getWrappedStep(wrappedStepName, providerName) 
 
  steps %Q{
    #{self_def_steps}
  }
end