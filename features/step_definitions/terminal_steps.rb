Given /^I start the app with "([^\"]*)"$/ do |command|
  @io = StringIO.new
  @app = Buzz.start(command.split(/\s+/), @io)
end

Given(/^I provide no options$/) do
  @app = Buzz.start([])
end

Then(/^I should see$/) do |string|
  pending # express the regexp above with the code you wish you had
end

Then /^the exit status should be (\d+)$/ do |exit_status|
  @last_exit_status.should == exit_status.to_i
end
