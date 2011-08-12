Then /^I should see the "([^\"]*)" link$/ do |text|
  css("a").detect { |e| e.text == text }.should_not(be_nil, "Expected to see the #{text.inspect} link, but did not.")
end

Then /^I should not see the "([^\"]*)" link$/ do |text|
  css("a").detect { |e| e.text == text }.should(be_nil, "Expected not to see the #{text.inspect} link, but did not.")
end

And /^I fill in blog with "([^\"]*)"$/ do |text|
  steps(%Q(And I fill in "wmd-input" with "#{text}"))
end

def css(selector)
  Nokogiri::HTML(body).css(selector)
end
