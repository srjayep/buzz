Given /^I have buzz installed$/ do
  add_to_lib_path(BUZZ_LIB_PATH)
end

Given(/^the config is "(.*?)"$/) do |config_file|
  put_config_in_place config_file
end

When(/^the cassette "(.*?)" is in place$/) do |cassette_name|
  VCR.use_cassette(cassette_name)
end

When(/^I run `([^`]*)` using the cassette "(.*?)"$/) do |command, cassette_name|
  VCR.use_cassette(cassette_name) { run_simple(unescape(command), false) }
end