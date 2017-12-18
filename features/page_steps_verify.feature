Feature: Verify page steps
@page_steps

Scenario: example_visit_page
Given I visit "google_first_page" page
Then I am on the page "google_first_page"

When I visit "google_first_page" page using Url "https://www.google.com/search?q=123"

Given I set variable "var_url" to "https://www.bing.com"
When I visit "google_first_page" page using Url in variable "var_url"
When I visit "google_first_page" page using query string "q=123"

Given I turn on ignore steps switch
Given I set variable "var_query_str" to "q=456789"
When I visit "google_first_page" page using query string in variable "var_query_str"
Given I turn off ignore steps switch

Then I am on the page "google_first_page" or page "gd_login_page"
Then I am on the page "google_first_page" or page "gd_login_page" or page "bing_first_page"

Given I visit "bing_first_page" page
Then I wait for the page "google_first_page" for "20" seconds


@windows_steps
Scenario: example_visit_page
Given I visit "w3c_page" page
Then I am on the page "w3c_page"
And I click "tag_input"
And I click "try_it"
And I switch to the most recent window
And I switch to the main window
And I close last window and switch back to window
