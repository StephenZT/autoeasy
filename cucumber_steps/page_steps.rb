# encoding=utf-8

When(/^I visit "([^"]*)" page$/) do |pageName|
  google_page = PageFactory.getPage(pageName, Configuration.getPlatform(), {:force_refresh=>true})
  google_page.action().go_to(google_page.url)
  google_page.action().wait_for_ready(10)
end

Then(/^I am on the page "([^"]*)"$/) do |pageName|
  google_page = PageFactory.getPage(pageName, Configuration.getPlatform())
  google_page.assert().assert_url("contains",google_page.url)
end
