class AddUrlToTestUrl < ActiveRecord::Migration[5.0]
  def change
    add_column :test_urls, :url, :string
  end
end
