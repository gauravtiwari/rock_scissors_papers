json.(move, :id, :opponent_id, :player_id, :winner_id)
json.choice opponent ? move.opponent_choice : move.player_choice
json.draw move.draw?
json.completed move.completed?
json.played opponent ? move.opponent_choice.present? : move.player_choice.present?
json.is_owner opponent ? current_player == move.opponent : current_player == move.player