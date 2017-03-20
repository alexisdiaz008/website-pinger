class TestUrl < ApplicationRecord
	validates :url, :request, :presence => true

	require 'twilio-ruby'

	def self.send_mms
		client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']
		client.messages.create(
		  from: '+17868375211',
		  to: '+13056070549',
		  body: 'Cliff Bot: WE GOT BIG PROBLEMS HERE!',
		  # media_url: 'http://vignette1.wikia.nocookie.net/cybernations/images/0/03/Nuke.jpg/revision/latest?cb=20060723162018'
		)
	end

	def set_task
		scheduler = Rufus::Scheduler.new
		scheduler.every self.frequency do
		  response=self.get_url
		  if response.code == (404 || 500)
		  	# Expand on condition/refactor for more cases, and begin Post design
		  	TestUrl.send_mms
		  end
		  Rails.logger.info "#{response.code} for #{self.url} at #{self.frequency} intervals"
		end
	end

	def get_url
		HTTParty.get(self.url)
	end

end
