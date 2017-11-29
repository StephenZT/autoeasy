#<<page_name>> : is variable that defined in you data provider
G_WrapStepRegister.registerWrappedStep("Login",
  [
    'Given I visit "<<page_name>>" page',
    'When I am on the page "<<page_name>>"'
  ]
)