json.array!(@pols) do |pol|
  json.extract! pol, :id
  json.url api_pol_url(pol, format: :json)
end
