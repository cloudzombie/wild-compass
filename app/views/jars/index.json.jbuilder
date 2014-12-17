json.array!(jars) do |jar|
  json.extract! jar, :id
  json.url jar_url(jar, format: :json)
end
