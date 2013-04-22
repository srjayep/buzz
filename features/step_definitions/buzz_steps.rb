Given /^I have buzz installed$/ do
  add_to_lib_path(BUZZ_LIB_PATH)
end

Given(/^the config is "(.*?)"$/) do |config_file|
  put_config_in_place config_file
end