class Othersmile < ActiveRecord::Base
  belongs_to :user, optional: true
  belongs_to :smile, optional: true
end
