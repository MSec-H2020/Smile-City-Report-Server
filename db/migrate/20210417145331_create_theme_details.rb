class CreateThemeDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :theme_details do |t|
      t.integer :theme_id
      t.integer :lang
      t.string :title
      t.string :message

      t.timestamps
    end
  end
end
