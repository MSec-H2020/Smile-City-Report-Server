class ThemeDetail < ApplicationRecord
  belongs_to :theme
  enum lang: [:ja, :en]

  scope :by_area, ->(area) { find_by(lang: Area::LANG[area.to_sym]) }
end
