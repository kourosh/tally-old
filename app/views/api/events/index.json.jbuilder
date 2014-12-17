json.array!(@events) do |event|
  json.extract! event, :id, :headline, :source, :pol_id
  json.url api_event_url(event, format: :json)
  json.extract! event.pol, :fullname, :bioguide_id, :party, :title, :state, :created_at, :updated_at
end

