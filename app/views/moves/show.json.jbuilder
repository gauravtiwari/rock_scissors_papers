json.move do
  json.partial! 'moves/moves', resource: @play
  json.partial! 'plays/play', resource: @play
end