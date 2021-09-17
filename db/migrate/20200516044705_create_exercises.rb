class CreateExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :exercises do |t|
      t.integer :exercise_time
      t.float :barometer_max
      t.float :barometer_min
      t.float :barometer_average
      t.float :barometer_standard_deviation
      t.integer :distance
      t.float :speed_max
      t.float :speed_min
      t.float :speed_average
      t.float :speed_standard_deviation
      t.integer :speed_dash_count
      t.float :acc_x_max
      t.float :acc_x_min
      t.float :acc_x_average
      t.float :acc_x_standard_deviation
      t.float :acc_x_rotation_count
      t.float :acc_y_max
      t.float :acc_y_min
      t.float :acc_y_average
      t.float :acc_y_standard_deviation
      t.float :acc_y_rotation_count
      t.float :acc_z_max
      t.float :acc_z_min
      t.float :acc_z_average
      t.float :acc_z_standard_deviation
      t.float :acc_z_rotation_count
      t.references :smile, foreign_key: true

      t.timestamps
    end
  end
end
