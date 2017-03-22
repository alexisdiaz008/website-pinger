class TestUrl < ApplicationRecord
	validates :url, :request, :presence => true
	include ActionView::Helpers::DateHelper
	require 'twilio-ruby'
	require 'rake'

	def self.create_fatj_sweeper(params)
		TestUrl.create({:url => "http://www.findatruckerjob.com/jobs?company=", :request => "GET", :frequency => params[:frequency], :role => "fatj-sweeper"})
	end

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
		scheduler.every self.frequency do
		  self.request == "GET" ? response=self.get : response=self.post(self.post_params)
			self.update_attributes(last_request: Time.now)
		  if response.code == (404 || 500)
		  	# Expand on condition/refactor for more cases, and begin Post design
		  	TestUrl.send_mms(self, response)
		  end
		  Rails.logger.info "Code #{response.code} for #{self.url}, pinged #{self.last_request_humanize} ago, next ping in #{self.frequency}"
		end
	end

	def set_fatj_sweep
		scheduler = Rufus::Scheduler.new
		scheduler.every self.frequency do
		  response=self.ping_fatj
			self.update_attributes(last_request: Time.now)
		end
	end

  def self.fatj_slug_array
  	response=HTTParty.get("http://www.findatruckerjob.com/api/companies/slugs")
		JSON.parse(response.body)
  end

	def ping_fatj
		TestUrl.fatj_slug_array.each do |slug|
			response=HTTParty.get("http://www.findatruckerjob.com/jobs?company=#{slug}")
		  if response.code == (404 || 500)
		  	TestUrl.send_mms(self, response)
		  end
		  Rails.logger.info "Code #{response.code} for #{self.url+slug}, pinged #{self.last_request_humanize} ago, next ping in #{self.frequency}"
		end
	end

	def last_request_humanize
		distance_of_time_in_words(self.last_request, self.last_request) if self.last_request.present?
	end

	def get
		HTTParty.get(self.url)
	end

	def post(params)
		HTTParty.post(self.url,eval(params))
	end

	private

	def self.run_rake(task)
    load File.join("#{Rails.root}", 'lib', 'tasks', "heroku.rake")
    Rake::Task[task].invoke
  end


end
