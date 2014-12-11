json.array!(@pols) do |pol|
  json.extract! pol, :id
  json.url pol_url(pol, format: :json)
end
