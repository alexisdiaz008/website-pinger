class AddRoleToTestUrl < ActiveRecord::Migration[5.0]
  def change
    add_column :test_urls, :role, :string
  end
end
