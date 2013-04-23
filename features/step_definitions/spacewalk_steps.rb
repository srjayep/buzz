Given(/^I have provided username "(.*?)" password "(.*?)" and server "(.*?)"$/) do |username, password, server|
   @system_api = Buzz::Api::System.new(server, username, password)
end

When(/^I call the "(.*?)" method and the cassette "(.*?)" is in place$/) do |method_name, cassette_name|
  VCR.use_cassette(cassette_name) {  @result = @system_api.send( method_name ) }
end

Then(/^the result contains:$/) do |string|
  @result.to_s.should include(string) 
end