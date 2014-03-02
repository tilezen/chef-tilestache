require 'chefspec'
require 'chefspec/berkshelf'

# load custom matchers
Dir.glob('spec/support/matchers/*.rb') do |custom_matcher|
  load "#{custom_matcher}"
end

RSpec.configure do |config|
  # some (optional) config here
end

#at_exit { ChefSpec::Coverage.report! }
