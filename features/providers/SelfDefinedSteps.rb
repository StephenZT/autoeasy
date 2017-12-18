#<<page_name>> : is variable that defined in you data provider
class LoginStepProvider < AutoEasy::Core::StepProvider
  def initialize()
    super()
    addStep('Given I visit "<<page_name>>" page')
    addStep('When I am on the page "<<page_name>>"')
  end
end

G_StepProviderRegister.registerWrappedStep("Login_Class",LoginStepProvider.to_s)

G_StepProviderRegister.registerWrappedStep("Login",
  [
    'Given I visit "<<page_name>>" page',
    'When I am on the page "<<page_name>>"'
  ]
)

