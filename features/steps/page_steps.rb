# encoding=utf-8

When(/^I visit "([^"]*)" page$/) do |pageName|
  google_page = PageFactory.getPage(pageName, Configuration.getConfig()['platform'], {:force_refresh=>true})
  google_page.action().go_to(google_page.url)
  google_page.action().wait_for_ready(10)
end
