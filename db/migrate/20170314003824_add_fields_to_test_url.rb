class AddFieldsToTestUrl < ActiveRecord::Migration[5.0]
  def change
    add_column :test_urls, :request, :string
    add_column :test_urls, :response_code, :string
    add_column :test_urls, :response_body, :string
    add_column :test_urls, :frequency, :string
  end
end
