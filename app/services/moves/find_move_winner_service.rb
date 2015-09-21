class FindMoveWinnerService

  WINNING_MOVES = {
   "paper-rock": 'paper',
   "rock-scissors": 'rock',
   "scissor-paper": 'scissors',
   "paper-spock": 'paper',
   "paper-lizard": 'lizard',
   "rock-spock": 'spock',
   "spock-lizard": 'lizard',
   "rock-lizard": 'rock',
   "scissor-spock": 'spock',
   "scissor-lizard": 'scissors'
  }

  def initialize(move)
    @move = move
  end

  def execute
    winner
  end

  private

  def winner
    @move.player_choice ==  winning_move ? @move.player : @move.opponent
  end

  def winning_move
    WINNING_MOVES[:"#{@move.player_choice}-#{@move.opponent_choice}"] || WINNING_MOVES[:"#{@move.opponent_choice}-#{@move.player_choice}"]
  end

end