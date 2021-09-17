json.result true
json.data do
  if not @themes.nil?
    json.themes do
      json.array!(@themes) do |theme|
        json.partial! 'theme', theme: theme, area: @area
      end
    end
  end

  if not @theme.nil?
    json.theme do
      json.partial! 'theme', theme: @theme, area: @area
    end
  end
end

