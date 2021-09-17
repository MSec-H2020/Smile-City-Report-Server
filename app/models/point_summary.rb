class PointSummary < ApplicationRecord
  has_many :rivals, class_name: "User"
end
