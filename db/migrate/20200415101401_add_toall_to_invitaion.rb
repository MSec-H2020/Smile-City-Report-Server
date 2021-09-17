class AddToallToInvitaion < ActiveRecord::Migration[5.2]
  def change
    add_column :invitations, :to_all, :Boolean
  end
end
