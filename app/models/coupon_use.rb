class CouponUse < ApplicationRecord
  belongs_to :coupon, optional: true
end
