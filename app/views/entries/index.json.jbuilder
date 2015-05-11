json.array!(@entries) do |entry|
  json.extract! entry, :id, :content
  json.url entry_url(entry, format: :json)
end
