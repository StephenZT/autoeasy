class TestDataProvider < AutoEasy::Core::BaseProvider
  def initialize(opts={})
    super(opts)
    addDate('page_name',"google_first_page")
  end

end
G_ProviderRegister.addProvider('PageNames_Data',TestDataProvider.new)