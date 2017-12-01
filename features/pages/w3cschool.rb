require File.expand_path(File.dirname(__FILE__)) + "/../../Packages.rb"

#Page definition
page_data = { 'tag_input'=> {
                          'desktop'=>{:xpath=>'//a[@href="tag_input.asp"]',:text=>'<input>'}
                          },
              'try_it'=> {
                          'desktop'=>{:xpath=>'//a[@href="tryit.asp?filename=tryhtml_form_submit"]',:text=>'Try it Yourself'}
                          },
              
            }
            
G_PageRegister.registerPage('w3c_page', page_data, {:url=>"https://www.w3schools.com/tags/"})
