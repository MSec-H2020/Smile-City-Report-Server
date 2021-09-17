class ChangeColumnToUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :auth_revision, :string

    add_column :users, :FBtoken, :string

  end
end
