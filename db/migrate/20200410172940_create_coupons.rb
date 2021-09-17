class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :title
      t.string :description
      t.integer :point
      t.string :imageUrl

      t.timestamps
    end
  end
end
