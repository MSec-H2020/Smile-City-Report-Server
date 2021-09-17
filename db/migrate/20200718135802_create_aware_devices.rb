class CreateAwareDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :aware_devices do |t|
      t.integer :user_id
      t.string :aware_id

      t.timestamps
    end
  end
end
