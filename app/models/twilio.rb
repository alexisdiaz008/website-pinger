class Twilio < ApplicationRecord
	require 'twilio-ruby'

	def send_mms
		client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']
		client.messages.create(
		  from: '+17868375211',
		  to: '+13056070549',
		  body: 'Cliff Bot: WE GOT BIG PROBLEMS HERE!',
		  media_url: 'http://vignette1.wikia.nocookie.net/cybernations/images/0/03/Nuke.jpg/revision/latest?cb=20060723162018'
		)
	end

end
