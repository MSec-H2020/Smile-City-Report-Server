class ChangeDataAccXRotationCountToExercise < ActiveRecord::Migration[5.2]
  def change
    change_column :exercises, :acc_x_rotation_count, :integer
    change_column :exercises, :acc_y_rotation_count, :integer
    change_column :exercises, :acc_z_rotation_count, :integer
  end
end
