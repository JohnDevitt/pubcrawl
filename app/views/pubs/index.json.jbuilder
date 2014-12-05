json.array!(@pubs) do |pub|
  json.extract! pub, :id, :name, :latitude, :longitude
  json.url pub_url(pub, format: :json)
end
