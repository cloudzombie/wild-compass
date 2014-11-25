json.array!(@plants) do |plant|
  json.extract! plant, :id
  json.url plant_url(plant, format: :json)
end
