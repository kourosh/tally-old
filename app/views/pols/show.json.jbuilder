json.extract! @pol, :id, :created_at, :updated_at
json.array!(@pol.events) do |event|
  json.extract! event, :id, :headline, :source, :pol_id
end