class AddThemeRefToInvitation < ActiveRecord::Migration[5.2]
  def change
    add_reference :invitations, :theme, foreign_key: true
  end
end
