class TestDataProvider < AutoEasy::Core::BaseProvider
  def initialize()
    @data = Hash.new
    @data['page_name'] = "google_first_page"
  end
  
  def getData(key)
    @data[key]
  end
end
G_ProviderRegister.addProvider('PageNames_Data',TestDataProvider.new)