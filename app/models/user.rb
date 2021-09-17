class User < ActiveRecord::Base
  mount_uploader :profile_path, ImageUploader

  has_many :smiles
  has_many :locations
  has_many :othersmiles
  has_many :comments
  has_many :blocks, foreign_key: 'blocked_by_user_id', class_name: 'Block'
  has_many :block_users, through: :blocks
  belongs_to :user_groups, optional: true

  has_many :invited_user_themes
  has_many :themes, through: :invited_user_themes

  has_many :joining_user_themes
  has_many :themes, through: :joining_user_themes

  has_many :user_all_points

  has_one :invitation

  validates :nickname, uniqueness: true


  def self.authorize(nickname, password)
    sha256 = Digest::SHA256.new
    User.find_by(
      nickname: nickname,
      password: sha256.hexdigest(password)
    )
  end
end
