json.move do
  json.partial! 'moves/moves', resource: @play
  json.game_completed @play.completed?
  json.player_score @play.player_score.value
  json.opponent_score @play.opponent_score.value
end