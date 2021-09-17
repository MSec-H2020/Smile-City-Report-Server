class AddUserRefToPointSummary < ActiveRecord::Migration[5.2]
  def change
    add_reference :point_summaries, :user
  end
end
