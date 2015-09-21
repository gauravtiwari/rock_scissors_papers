json.opponent_moves @play.opponent_moves.where(play_id: @play.id).each do |move|
  json.partial! 'moves/move', locals: { move: move, opponent: true} if move.opponent_choice.present?
end
json.player_moves @play.player_moves.where(play_id: @play.id).each do |move|
  json.partial! 'moves/move', locals: { move: move, opponent: false} if move.player_choice.present?
end