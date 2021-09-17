class AddColumnToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :auth_revision, :string
  end
end
