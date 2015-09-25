class Play < ActiveRecord::Base

  #Include Redis
  include Redis::Objects

  #Associations
  has_many :messages, dependent: :destroy
  belongs_to :player
  belongs_to :opponent, foreign_key: 'opponent_id', class_name: 'Player'
  belongs_to :looser, foreign_key: 'looser_id', class_name: 'Player'
  belongs_to :winner, foreign_key: 'winner_id', class_name: 'Player'

  # Callback to update play and player counters
  after_commit :update_counters, :update_winners, if: :completed?, on: :update

  # Redis fields and counters
  counter :player_score
  value :last_move_id
  counter :opponent_score
  counter :moves_count

  #Public interface methods

  public

  # Check if play is completed
  def completed?
    min_moves == moves_count.value
  end

  # Check if play is draw
  def draw?
    player_score.value == opponent_score.value
  end

  # Find winning player based on score
  def winning_player_id
    return nil if draw?
    player_score.value > opponent_score.value ? player_id : opponent_id
  end

  # Find loosing player
  def loosing_player_id
    return nil if draw?
    winning_player_id == player_id ? opponent_id : player_id
  end

  # Update redis counters once play completed
  def update_counters
    player.plays_count.increment
    opponent.plays_count.increment
    true
  end

  # Update redis counters for winner and looser
  def update_winners
    return true if draw?
    winner.wins_count.increment
    Player.rank.incr(winner.id)
    looser.loose_count.increment
    true
  end

  # Check if play completed
  def player_status(player)
    return "Draw" if draw?
    player.id == winner_id ? "Won" : "Lost"
  end

  # Check if moves completed
  def not_played_by?(player)
    opponent?(player) ?
      opponent_moves.last.opponent_choice.nil? :
      player_moves.last.player_choice.nil?
  end

  # Find opponent moves
  def opponent_moves
    opponent.opponent_moves.order(id: :asc).where(play_id: self.id) if opponent_id.present?
  end

  # Find player moves
  def player_moves
    player.moves.order(id: :asc).where(play_id: self.id) if player_id.present?
  end

  # Check if opponent
  def opponent?(player)
    opponent_id == player.id
  end

end
