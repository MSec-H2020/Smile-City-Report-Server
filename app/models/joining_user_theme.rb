class JoiningUserTheme < ApplicationRecord
  belongs_to :theme, optional: true
  belongs_to :user, optional: true
end
