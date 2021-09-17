class AddExerciseRefToSmiles < ActiveRecord::Migration[5.2]
  def change
    add_reference :smiles, :exercise, foreign_key: true
  end
end
