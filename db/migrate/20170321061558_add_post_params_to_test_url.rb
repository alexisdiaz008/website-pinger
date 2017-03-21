class AddPostParamsToTestUrl < ActiveRecord::Migration[5.0]
  def change
    add_column :test_urls, :post_params, :string
  end
end
