class CreateThemes < ActiveRecord::Migration[5.2]
  def change
    create_table :themes do |t|
      t.string :area
      t.string :title
      t.string :message
      t.string :timestmap
      t.string :image

      t.timestamps
    end
  end
end
