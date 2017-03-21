class TestUrl < ApplicationRecord
	validates :url, :request, :presence => true

	require 'twilio-ruby'

	def self.send_mms(test_url, response)
		client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']
		client.messages.create(
		  from: '+17868375211',
		  to: "#{ENV['TWILIO_NUMBER']}",
		  body: "Alert!!! Code #{response.code} for #{test_url.url}" ,
		  media_url: 'http://vignette1.wikia.nocookie.net/cybernations/images/0/03/Nuke.jpg/revision/latest?cb=20060723162018'
		)
	end

	def set_task
		scheduler = Rufus::Scheduler.new
	  if self.request == "GET"
		  response=self.get
		else
			response=self.post(self.post_params)
		end
		scheduler.every self.frequency do
		  if response.code == (404 || 500)
		  	# Expand on condition/refactor for more cases, and begin Post design
		  	TestUrl.send_mms(self, response)
		  end
		  Rails.logger.info "#{response.code} for #{self.url} at #{self.frequency} intervals"
		end
	end

	def get
		HTTParty.get(self.url)
	end

	def post(params)
		HTTParty.post(self.url,eval(params))
	end

end
