class Move < ActiveRecord::Base

  #Associations
  belongs_to :play
  belongs_to :player
  belongs_to :opponent, foreign_key: 'opponent_id', class_name: 'Player'
  belongs_to :winner, foreign_key: 'winner_id', class_name: 'Player'

  #Public interface methods
  public

  # Check if move completed
  def completed?
    opponent_choice.present? and player_choice.present?
  end

  # Check if move is draw?
  def draw?
    player_choice == opponent_choice
  end

end
