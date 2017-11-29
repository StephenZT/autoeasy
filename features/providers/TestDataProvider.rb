class TestDataProvider < AutoEasy::Core::DataProvider
  def initialize(opts={})
    super(opts)
    addData('page_name',"google_first_page")
    addData('0:page_name',"google_first_page")
  end
end

G_DataProviderRegister.addProvider('PageNames_Data_Class',TestDataProvider.to_s)

G_DataProviderRegister.addProvider('PageNames_Data_Hash',{'page_name' => 'google_first_page','0'=>{'page_name' => 'google_first_page'}})
