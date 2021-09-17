class AddInvitedRefToInvitation < ActiveRecord::Migration[5.2]
  def change
    add_reference :invitations, :invited, foreign_key: {to_table: :users}
  end
end
