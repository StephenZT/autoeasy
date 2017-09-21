# encoding=utf-8
require File.expand_path(File.dirname(__FILE__)) + "/../../Packages.rb"

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


G_PageRegister.registerPage('gd_login_page',LoginPage.to_s,{:url=>"https://www.google.com"})
