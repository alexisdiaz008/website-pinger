class TestUrl < ApplicationRecord
	validates :url, :request, :presence => true
	include ActionView::Helpers::DateHelper
	require 'twilio-ruby'
	require 'rake'

	def self.create_fatj_sweeper(params)
		TestUrl.create({:url => "http://www.findatruckerjob.com/jobs?company=", :request => "GET", :frequency => params[:frequency], :role => "fatj-sweeper"})
	end

	def self.send_mms(response)
		client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']
		client.messages.create(
		  from: '+17868375211',
		  to: "#{ENV['TWILIO_NUMBER']}",
		  body: "Alert!!! Code #{response.code} for #{response.request.last_uri.to_s}, pinged #{Time.now.strftime("%A%l:%M %P at %B %d, %Y")}" ,
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
		  	TestUrl.send_mms(response)
		  end
		  self.logger(response)
		end
	end

	def set_fatj_sweep
		scheduler = Rufus::Scheduler.new
		scheduler.every self.frequency do
		  self.ping_fatj_company_job_index
		  self.ping_fatj_company_job_pages
			self.update_attributes(last_request: Time.now)
		end
	end

  def self.fatj_slug_array
  	slugs=HTTParty.get("http://www.findatruckerjob.com/api/companies/slugs")
		JSON.parse(slugs.body)
  end

	def ping_fatj_company_job_index
		TestUrl.fatj_slug_array.each do |slug|
			response=HTTParty.get("http://www.findatruckerjob.com/jobs?company=#{slug}")
		  if response.code == (404 || 500)
		  	TestUrl.send_mms(response)
		  end
		  self.logger(response)
		end
	end

  def self.fatj_urls_array
		urls=HTTParty.get("http://www.findatruckerjob.com/api/companies/job_sample")
		JSON.parse(urls.body)
  end

	def ping_fatj_company_job_pages
		TestUrl.fatj_urls_array.each do |url|
			response=HTTParty.get(url)
			if response.code == (404 || 500)
		  	TestUrl.send_mms(response)
		  end
		  self.logger(response)
		end
	end

	def logger(response)
		Rails.logger.info "Code #{response.code} for #{response.request.last_uri.to_s}, pinged #{Time.now.strftime("%A%l:%M %P at %B %d, %Y")}, next ping in #{self.frequency}"
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
