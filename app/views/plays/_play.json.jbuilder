json.player_badge @play.player.name_badge
json.player_name @play.player.name
json.opponent_name @play.opponent.name
json.opponent_badge @play.opponent.name_badge
json.player_score @play.player_score.value
json.opponent_score @play.opponent_score.value
json.is_opponent @play.opponent?(current_player)
json.game_completed @play.completed?
json.opponent_status @play.player_status(@play.opponent) if @play.completed?
json.player_status @play.player_status(@play.player) if @play.completed?