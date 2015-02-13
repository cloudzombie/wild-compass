json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :event, :source_id, :target_id, :weight
  json.url transaction_url(transaction, format: :json)
end
