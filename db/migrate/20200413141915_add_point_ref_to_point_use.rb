class AddPointRefToPointUse < ActiveRecord::Migration[5.2]
  def change
    add_reference :point_uses, :point
  end
end
