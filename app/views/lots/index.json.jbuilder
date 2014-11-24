json.array!(@lots) do |lot|
  json.extract! lot, :id
  json.url lot_url(lot, format: :json)
end
