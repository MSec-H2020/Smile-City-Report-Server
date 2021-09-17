class Group < ActiveRecord::Base
  belongs_to :user_groups, optional: true
end
