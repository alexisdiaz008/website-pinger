class PagesController < ApplicationController
	def test_page
	end

	def url_test
		@response = HTTParty.get(params[:test_url])
		respond_to do |format|
			format.js{ render :partial => 'pages/url_response_form' }
		end
	end
end