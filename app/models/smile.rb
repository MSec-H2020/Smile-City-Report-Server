class Smile < ActiveRecord::Base
  mount_uploader :pic_path, ImageUploader
  mount_uploader :back_pic_path, ImageUploader

  default_scope { order(created_at: :desc) }

  belongs_to :user, optional: true
  has_many :othersmiles
  has_many :comments

  has_many :smile_themes
  has_many :themes, through: :smile_themes

  has_one :exercise
end
