json.array!(@pots) do |pot|
  json.extract! pot, :id
  json.url pot_url(pot, format: :json)
end
