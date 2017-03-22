class AddLastRequestDateTimeToTestUrl < ActiveRecord::Migration[5.0]
  def change
    add_column :test_urls, :last_request, :datetime
  end
end
