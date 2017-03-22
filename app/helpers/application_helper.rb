module ApplicationHelper

	def humanize_last_request_for(test_url)
		test_url.last_request_humanize
	end

	def sweeper_or_url(test_url)
		test_url.url == "http://www.findatruckerjob.com/jobs?company=" ? "FATJ SWEEPER" : test_url.url
	end
end
