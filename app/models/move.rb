class Move < ActiveRecord::Base

  #Associations
  belongs_to :play
  belongs_to :player
  belongs_to :opponent, foreign_key: 'opponent_id', class_name: 'Player'
  belongs_to :winner, foreign_key: 'winner_id', class_name: 'Player'

  public

  def completed?
    opponent_choice.present? and player_choice.present?
  end

  def draw?
    player_choice == opponent_choice
  end

end
