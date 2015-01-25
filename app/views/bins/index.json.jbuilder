json.array!(@bins) do |bin|
  json.extract! bin, :id
  json.url bin_url(bin, format: :json)
end
