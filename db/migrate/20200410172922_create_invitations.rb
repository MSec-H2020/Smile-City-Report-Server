class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.string :code
      t.string :timestamp

      t.timestamps
    end
  end
end
