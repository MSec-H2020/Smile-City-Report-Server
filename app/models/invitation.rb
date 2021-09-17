class Invitation < ApplicationRecord
  belongs_to :inviter, class_name: "User", optional: true
  belongs_to :invited, class_name: "User", optional: true
  belongs_to :theme, optional: true
end
