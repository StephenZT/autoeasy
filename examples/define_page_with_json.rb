require File.expand_path(File.dirname(__FILE__)) + "/../Packages.rb"

#Page definition
page_data = {'searchInput'=> {
                          'desktop'=>{:id=>'lst-ib',:css=>'abc',:xpath=>'//body[abc]',:text=>'bbb'},
                          'mobile'=>{:id=>'lst-ib',:css=>'abc2',:xpath=>'//body[abc]2',:text=>'bbb2'}
                          },
              'searchButton'=> {
                          'desktop'=>{:css=>'[name=btnK]'},
                          'mobile'=>{:css=>'[name=btnK]'}
                          },
              'invalidEl'=> {
                          'desktop'=>{:css=>'[name=xxx]',:frame=>'searchInput'},
                          'mobile'=>{:css=>'[name=xxx]'}
                          }
            }
            
G_PageRegister.registerPage('google_first_page', page_data, {:url=>"http://www.google.com"})
#webdriver
G_ConfigHelper.conifg_enironment(["QA3","QA4"])
G_ConfigHelper.config_current_stage("QA4","desktop","chrome","Windows","Error")
G_ConfigHelper.config_databases("QA4","defualt",{:dataserver=>'GDCQA4SQL',:database=>'NEC'})
G_DriverFactory.getDriver(G_ConfigHelper.get_browser())

begin
  #creat new page 
  google_page = G_PageFactory.getPage('google_first_page','desktop')
  google_page.action().go_to(google_page.url)
  google_page.action().wait_for_ready(10)
 
  google_page.action().open_new_window()
  google_page.action().close_window()
  
  google_page.assert({:soft_assert=>true}).assert_url("==","https://www.google.com")
  google_page.getElement('invalidEl').assert().assert_invalid()
  google_page.getElement('searchInput').action().fill('abc')
  google_page.getElement('searchButton').action().click()
  google_page.getElement('searchInput').assert().assert_value("==",'abc')
  google_page.getElement('searchInput').action().fill('abcdefagasdgag212314325253')
  google_page.getElement('searchButton').action().click()
  google_page.getElement('searchInput').assert().assert_value("contains",'abc')
  LoggerTrace.assert_no_error_in_log()
  sleep(3)

  G_DriverFactory.currentDriver().quit
rescue Exception=>msg
  puts msg
  G_DriverFactory.currentDriver().quit
end
