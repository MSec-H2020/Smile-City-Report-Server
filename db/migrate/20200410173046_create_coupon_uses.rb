class CreateCouponUses < ActiveRecord::Migration[5.2]
  def change
    create_table :coupon_uses do |t|
      t.boolean :isUsed
      t.string :usedTime

      t.timestamps
    end
  end
end
