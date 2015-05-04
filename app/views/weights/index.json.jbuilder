json.array!(weights) do |weight|
  json.extract! weight, :id, :weighted_at, :value
  json.url weight_url(weight, format: :json)
end
