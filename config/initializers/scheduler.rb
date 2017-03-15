require 'rufus-scheduler'
require 'httparty'

# Let's use the rufus-scheduler singleton
#
s = Rufus::Scheduler.singleton

# unless defined?(Rails::Console) || File.split($0).last == 'rake'
# only schedule when not running from the Ruby on Rails console
  # or from a rake task

# Stupid recurrent task...
#
# TestUrl.all.each do |test_url|
# 	s.every test_url.frequency do
# 	  response=test_url.get_url
# 	  Rails.logger.info "#{response.code} for #{test_url.url} at #{test_url.frequency} intervals"
# 	end
# end

# s.every '5s' do
#   Rails.logger.info "hello, it's #{Time.now}"
#   Rails.logger.flush
# end