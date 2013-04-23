require 'vcr'

VCR.configure do |c|
  # INFO: This is relative to the Rails.root
  c.cassette_library_dir = 'features/fixtures/vcr_cassettes'
  c.hook_into :fakeweb
  c.ignore_localhost = true
  c.default_cassette_options = { :record => :new_episodes }
end

#VCR.cucumber_tags do |t|
#  t.tag  '@tag1'
#  t.tags '@tag2', '@tag3'

  # t.tag  '@tag3', :cassette => :options
 # puts "OPTONS #{t}"
 # t.tags '@tag4', '@tag5'
#end