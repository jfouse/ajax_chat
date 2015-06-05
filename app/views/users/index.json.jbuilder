json.array!(@users) do |user|
  json.extract! user, :id, :name, :hash_key
  json.url user_url(user, format: :json)
end
