json.array!(@locations) do |location|
  json.extract! location, :id, :name, :description, :plant_ids, :bin_ids, :container_ids
  json.url location_url(location, format: :json)
end
