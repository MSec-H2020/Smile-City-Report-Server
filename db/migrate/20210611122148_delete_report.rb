class DeleteReport < ActiveRecord::Migration[5.2]
  def change
    drop_table :reports
  end
end
