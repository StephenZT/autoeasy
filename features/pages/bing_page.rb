require File.expand_path(File.dirname(__FILE__)) + "/../../Packages.rb"

#Page definition
page_data = {'searchInput'=> {
                          'desktop'=>{:id=>'sb_form_q'},
                          'mobile'=>{:id=>'sb_form_q'}
                          },
              'searchButton'=> {
                          'desktop'=>{:id=>'sb_form_go'},
                          'mobile'=>{:id=>'sb_form_go'}
                          }
            }
            
G_PageRegister.registerPage('bing_first_page', page_data, {:url=>"https://www.bing.com/"})
