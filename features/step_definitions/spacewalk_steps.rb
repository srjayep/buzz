Given(/^I have provided username "(.*?)" password "(.*?)" and server "(.*?)"$/) do |username, password, server|
   @username = username
   @password = password
   @server = server
end

Given(/^want to use the "(.*?)" API$/) do |api_name|
  clazz = eval("Buzz::Api::#{api_name}")
  @api = clazz.new(@server, @username, @password)
end

When(/^I call the "(.*?)" method and the cassette "(.*?)" is in place$/) do |method_name, cassette_name|
  VCR.use_cassette(cassette_name) {  @result = @api.send( method_name ) }
end

When(/^I call the "(.*?)" method with the arguments "(.*?)" and the cassette "(.*?)" is in place$/) do |method_name, args, cassette_name|
  split_args = args.split(/ /)	
  args = split_args.length <= 1 ? args : split_args
  VCR.use_cassette(cassette_name) {  @result = @api.send( method_name, args ) }
end

When(/^I call the "(.*?)" method with the hash "(.*?)" and the cassette "(.*?)" is in place$/) do |method_name, args, cassette_name|
  hash_arg = eval(args)
  VCR.use_cassette(cassette_name) {  @result = @api.send( method_name, hash_arg ) }
end

Then(/^the result contains:$/) do |expected_result|
    @result.to_s.should eq(expected_result)
end


Then(/^the result contains the array:$/) do |string|
    expected_result = eval(string).to_json
    @result.to_json.should eq(expected_result)
end