class CreateUserAllPoints < ActiveRecord::Migration[5.2]
  def change
    create_table :user_all_points do |t|
      t.references :user, foreign_key: true
      t.integer :all_point

      t.timestamps
    end
  end
end
