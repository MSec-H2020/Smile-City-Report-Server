class PointUse < ApplicationRecord
  belongs_to :point, optional: true
  belongs_to :user, optional: true
end
