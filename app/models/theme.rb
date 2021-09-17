class Theme < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  default_scope { order(created_at: :desc) }
  scope :by_area, ->(area) { where(area: [area, Area::GLOBAL]) }
  scope :default_by_area, ->(area) { where(is_default: true).by_area(area) }

  has_one :detail_ja, -> { where(lang: :ja) }, class_name: "ThemeDetail"
  has_one :detail_en, -> { where(lang: :en) }, class_name: "ThemeDetail"

  has_many :invitation
  belongs_to :owner, class_name: "User", optional: true

  has_many :smile_themes
  has_many :smiles, through: :smile_themes

  has_many :invited_user_themes
  has_many :invited_users, through: :invited_user_themes, source: :user

  has_many :joining_user_themes
  has_many :joining_users, through: :joining_user_themes, source: :user
  has_many :theme_details

  scope :with_detail, ->(lang) {
    case lang
    when :en
      includes(:detail_en)
    when :ja
      includes(:detail_ja)
    end
  }

  def native_message(area)
    lang = Area::LANG[area.to_sym]

    return message if area.nil?

    detail = case lang
    when :en
      detail_en
    when :ja
      detail_ja
    end

    detail.present? ? detail.message : message
  end

  def native_title(area)
    lang = Area::LANG[area.to_sym]

    return title if area.nil?

    detail = case lang
    when :en
      detail_en
    when :ja
      detail_ja
    end

    detail.present? ? detail.title : title
  end
end
