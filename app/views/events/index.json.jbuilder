json.array!(@events) do |event|
  json.extract! event, :id, :headline, :source
  json.url event_url(event, format: :json)
  json.array!(@events) do |event|
  	json.extract! event.pol, :id, :created_at, :updated_at
	end
end

