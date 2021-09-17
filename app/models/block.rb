class Block < ApplicationRecord
  belongs_to :blocked_by_user,
    class_name: 'User', foreign_key: 'blocked_by_user_id'
  belongs_to :block_user,
    class_name: 'User', foreign_key: 'block_user_id'
end
