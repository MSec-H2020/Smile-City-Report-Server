json.result true
json.data do
  if not @themes.nil?
    json.themes do
      json.array!(@themes) do |theme|
        json.extract! theme, :id, :title, :owner_id, :public,
          :facing, :created_at, :updated_at, :image
        json.message theme.native_message(@area)
        json.title theme.native_title(@area)
      end
    end
  end

end

