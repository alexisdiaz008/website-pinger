class CreateTwilios < ActiveRecord::Migration[5.0]
  def change
    create_table :twilios do |t|

      t.timestamps
    end
  end
end
