Then /^I should see no services listed$/ do
  find("ul#services").should have_no_selector("li")
end

Then /^I should see the service "([^"]*)"$/ do |service|
  find("ul#services").should have_content(service)
end

Then /^I should not see a link to the "([^"]*)" service$/ do |service|
  find("ul#additional_services").should have_no_link(service)
end

Given /^I will (?:sign in|login) as "([^"]*)" through the "([^"]*)" service$/ do |email, service|
  add_oa_mock(service, email)
end
