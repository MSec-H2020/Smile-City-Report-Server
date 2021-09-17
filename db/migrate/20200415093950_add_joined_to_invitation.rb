class AddJoinedToInvitation < ActiveRecord::Migration[5.2]
  def change
    add_column :invitations, :joined, :boolean
  end
end
