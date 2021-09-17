class AddUsersToAwareId < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :aware_id, :string
  end
end
