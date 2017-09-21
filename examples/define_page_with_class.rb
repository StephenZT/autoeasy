# encoding=utf-8
require File.expand_path(File.dirname(__FILE__)) + "/../Packages.rb"

class LoginPage < AutoEasy::Core::Page
  def initialize(opts={})
    super(opts)
    initElements()
  end
  
  def initElements()
    addElement('searchInput', AutoEasy::Core::Element.new('searchInput',{
                          'desktop'=>{:id=>'lst-ib',:css=>'abc',:xpath=>'//body[abc]',:text=>'bbb'},
                          'mobile'=>{:id=>'lst-ib',:css=>'abc2',:xpath=>'//body[abc]2',:text=>'bbb2'}
                          })
     )
    
    addElement('searchButton', AutoEasy::Core::Element.new('searchButton',{
                          'desktop'=>{:css=>'[name=btnK]'},
                          'mobile'=>{:css=>'[name=btnK]'}
                          })
     )
  end
end


G_PageRegister.registerPage('gd_login_page',LoginPage.to_s,{:url=>"http://www.google.com"})

G_ConfigHelper.conifg_enironment(["QA3","QA4"])
G_ConfigHelper.config_current_stage("QA3","desktop","chrome","Windows","Error")
G_ConfigHelper.config_databases("QA4","defualt",{:dataserver=>'GDCQA4SQL',:database=>'NEC'})
G_DriverFactory.getDriver(G_ConfigHelper.get_browser())

begin
  #creat new page 
  google_page = G_PageFactory.getPage('gd_login_page','desktop',{:force_refresh=>true})
  google_page.action().go_to(google_page.url)
  google_page.action().wait_for_ready(10)
  google_page.assert().assert_url("contains","https://www.google.com")
  
  google_page.getElement('searchInput').action().fill('abc')
  google_page.getElement('searchButton').action().click()

  google_page.getElement('searchInput').assert().assert_value("==",'abc')
  google_page.getElement('searchInput').action().fill('abcdefagasdgag212314325253')
  google_page.getElement('searchButton').action().click()
  google_page.getElement('searchInput').assert().assert_value("==",'abc')
  LoggerTrace.assert_no_error_in_log()
  sleep(3)

  G_DriverFactory.currentDriver().quit
rescue Exception=>msg
  puts msg
  G_DriverFactory.currentDriver().quit
end
