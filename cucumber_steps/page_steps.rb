# encoding=utf-8

When(/^I visit "([^"]*)" page$/) do |pageName|
  get_page = G_PageFactory.getPage(pageName, G_ConfigHelper.get_platform(), {:force_refresh=>true})
  get_page.action().go_to(get_page.url)
  get_page.action().wait_for_ready(10)
end

Then(/^I am on the page "([^"]*)"$/) do |pageName|
  get_page = G_PageFactory.getPage(pageName, G_ConfigHelper.get_platform())
  get_page.assert().assert_url("contains",get_page.url)
end
