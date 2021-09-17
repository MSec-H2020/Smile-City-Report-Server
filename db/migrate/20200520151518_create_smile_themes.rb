class CreateSmileThemes < ActiveRecord::Migration[5.2]
  def change
    create_table :smile_themes do |t|
      t.references :smile, foreign_key: true
      t.references :theme, foreign_key: true

      t.timestamps
    end
  end
end
