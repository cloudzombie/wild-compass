json.array!(containers) do |container|
  json.extract! container, :id, :name, :current_weight, :initial_weight
  json.url container_url(container, format: :json)
end
