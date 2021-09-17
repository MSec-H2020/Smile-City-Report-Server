class CreateInvitedUserThemes < ActiveRecord::Migration[5.2]
  def change
    create_table :invited_user_themes do |t|
      t.integer :user_id
      t.integer :theme_id

      t.timestamps
    end
  end
end
