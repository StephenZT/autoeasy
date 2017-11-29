class TestDataProvider < AutoEasy::Core::BaseProvider
  def initialize(opts={})
    super(opts)
    addData('page_name',"google_first_page")
  end
end
G_ProviderRegister.addProvider('PageNames_Data_Class',TestDataProvider.to_s)

G_ProviderRegister.addProvider('PageNames_Data_Hash',{'page_name' => 'google_first_page'})
