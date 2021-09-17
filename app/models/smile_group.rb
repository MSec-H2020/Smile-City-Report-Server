class SmileGroup < ActiveRecord::Base
  has_many :smiles
  has_many :groups
end