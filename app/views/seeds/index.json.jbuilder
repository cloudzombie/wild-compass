json.array!(seeds) do |seed|
  json.extract! seed, :id, :name
  json.url seed_url(seed, format: :json)
end
