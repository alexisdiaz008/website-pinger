module ApplicationHelper

	def humanize_last_request_for(test_url, time)
		distance_of_time_in_words(test_url.last_request, time) if test_url.last_request.present?
	end

	def sweeper_or_url(test_url)
		test_url.url == "http://www.findatruckerjob.com/jobs?company=" ? "FATJ company index page tester" : test_url.url
	end
end
