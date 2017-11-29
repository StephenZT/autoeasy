Feature: Visit page_wrap_steps
@example_visit_page_wrap_steps

Scenario: example_visit_page
Given I execute wrapped steps "Login" with data provider "PageNames_Data_Class"
And I execute wrapped steps "Login" with data provider "PageNames_Data_Hash"