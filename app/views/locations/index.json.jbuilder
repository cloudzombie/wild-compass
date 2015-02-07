json.array!(locs) do |loc|
  json.extract! loc, :id, :name, :description, :plant_ids, :bin_ids, :container_ids
  json.url loc_url(loc, format: :json)
end
