json.result true
json.data do
  if not @smiles.nil?
    json.smiles do
      json.array!(@smiles) do |smile|
        json.partial! 'smile', smile: smile
      end
    end
  end

  if not @smile.nil?
    json.smile do
      json.partial! 'smile', smile: @smile
    end
  end
end