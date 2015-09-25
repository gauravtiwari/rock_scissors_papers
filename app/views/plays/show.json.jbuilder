json.play do
  json.(@play, :id, :opponent_id, :player_id, :created_at)
  json.partial! 'moves/moves', resource: @play
  json.partial! 'plays/play', resource: @play
end