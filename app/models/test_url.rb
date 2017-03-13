class TestUrl < ApplicationRecord
	validates :url, :presence => true

	def get_url
		HTTParty.get(self.url)
	end

end
