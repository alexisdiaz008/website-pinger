class TestUrl < ApplicationRecord
	validates :url, :request, :presence => true

	def get_url
		HTTParty.get(self.url)
	end

end
