class CreateSmileReport < ActiveRecord::Migration[5.2]
  def change
    create_table :smile_reports do |t|
      t.integer :smile_id
      t.integer :user_id
      t.timestamps
    end
  end
end
