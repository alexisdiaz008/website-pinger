require 'rufus-scheduler'
require 'httparty'
require 'twilio-ruby'

# Let's use the rufus-scheduler singleton
#
s = Rufus::Scheduler.singleton

# unless defined?(Rails::Console) || File.split($0).last == 'rake'
# only schedule when not running from the Ruby on Rails console
  # or from a rake task

# recurrent tasks...
#
TestUrl.all.each do |test_url|
	# s.every test_url.frequency do
		test_url.set_task
	# end
end

# TestUrl.all.each do |test_url|
s.every '3s' do
puts "hello, it's #{Time.now}"
end
# end

# s.every '5s' do
#   Rails.logger.info "hello, it's #{Time.now}"
#   Rails.logger.flush
# end