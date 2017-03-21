class PagesController < ApplicationController
	def test_page
	end

	def url_test
		if params[:request_type] == "GET"
			@response = HTTParty.get(params[:test_url])
		else
			@response = HTTParty.post(params[:test_url], eval(params[:post_params]))
		end
		respond_to do |format|
			format.js{ render :partial => 'pages/url_response_form' }
		end
	end
end