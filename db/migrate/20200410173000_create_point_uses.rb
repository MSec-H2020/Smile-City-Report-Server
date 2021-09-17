class CreatePointUses < ActiveRecord::Migration[5.2]
  def change
    create_table :point_uses do |t|
      t.string :timestamp

      t.timestamps
    end
  end
end
