class Play < ActiveRecord::Base

  #Include Redis
 include Redis::Objects

  #Associations
  has_many :messages, dependent: :destroy
  belongs_to :player
  belongs_to :opponent, foreign_key: 'opponent_id', class_name: 'Player'
  belongs_to :winner, foreign_key: 'winner_id', class_name: 'Player'

  after_commit :update_counters, if: :completed?, on: :update

  #Redis fields and counters
  counter :player_score
  value :last_move_id
  counter :opponent_score
  counter :moves_count

  public

  def completed?
    min_moves == moves_count.value
  end

  def update_counters
    player.plays_count.increment
    winner.plays_count.increment
    opponent.plays_count.increment
    winner.wins_count.increment
    looser.loose_count.increment
  end

  def opponent_moves
    opponent.opponent_moves.where(play_id: self.id) if opponent_id.present?
  end

  def not_played_by?(player)
    opponent?(player) ? opponent_moves.where(play_id: self.id).last.opponent_choice.nil? : player_moves.where(play_id: self.id).last.player_choice.nil?
  end

  def looser
    winner_id == player_id ? player : opponent
  end

  def player_moves
    player.moves.where(play_id: self.id) if player_id.present?
  end

  def opponent?(player)
    opponent == player
  end

end
