class CreateTestUrls < ActiveRecord::Migration[5.0]
  def change
    create_table :test_urls do |t|

      t.timestamps
    end
  end
end
