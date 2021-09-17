class RemoveSpeedMinFromExercise < ActiveRecord::Migration[5.2]
  def change
    remove_column :exercises, :speed_min, :Float
  end
end
