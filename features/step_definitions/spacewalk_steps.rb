Given(/^I have provided username "(.*?)" password "(.*?)" and server "(.*?)"$/) do |username, password, server|
   @system_api = Buzz::Api::System.new(server, username, password)
end

When(/^I call the "(.*?)" method and the cassette "(.*?)" is in place$/) do |method_name, cassette_name|
  VCR.use_cassette(cassette_name) {  @result = @system_api.send( method_name ) }
end

When(/^I call the "(.*?)" method with the arguments "(.*?)" and the cassette "(.*?)" is in place$/) do |method_name, args, cassette_name|
  args = args.split(/ /)	
  VCR.use_cassette(cassette_name) {  @result = @system_api.send( method_name, args ) }
end

Then(/^the result contains:$/) do |expected_result|
    @result.to_s.should eq(expected_result)
end


Then(/^the result contains the array:$/) do |string|
    expected_result = eval(string).to_json
    @result.to_json.should eq(expected_result)
end