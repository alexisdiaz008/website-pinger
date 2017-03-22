require 'rufus-scheduler'
require 'httparty'
require 'twilio-ruby'
include ApplicationHelper

# Let's use the rufus-scheduler singleton
#
s = Rufus::Scheduler.singleton

# unless defined?(Rails::Console) || File.split($0).last == 'rake'
# only schedule when not running from the Ruby on Rails console
  # or from a rake task

# recurrent tasks...
#
TestUrl.all.each do |test_url|
	test_url.role=="fatj-sweeper" ? test_url.set_fatj_sweep : test_url.set_task
	s.in "#{Time.now+3.seconds}" do
		Rails.logger.info "Setting Pinger Schedule for #{sweeper_or_url(test_url)}, next ping in #{test_url.frequency}"
	end
	# puts "Setting Schedule for test url #{test_url.id}, next ping in #{test_url.frequency}"
end

# TestUrl.all.each do |test_url|
# s.every '3s' do
# puts "hello, it's #{Time.now}"
# end
# end

# s.every '5s' do
#   Rails.logger.info "hello, it's #{Time.now}"
#   Rails.logger.flush
# end