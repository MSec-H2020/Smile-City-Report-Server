class AddEmotionToExercise < ActiveRecord::Migration[5.2]
  def change
    add_column :exercises, :satisfaction, :integer
    add_column :exercises, :emotion, :integer
  end
end
