json.array!(@plays) do |play|
  json.extract! play, :id
  json.url play_url(play, format: :json)
end
