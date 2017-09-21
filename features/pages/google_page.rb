require File.expand_path(File.dirname(__FILE__)) + "/../../Packages.rb"

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
            
G_PageRegister.registerPage('google_first_page', page_data, {:url=>"https://www.google.com"})
