require 'test_helper'

class MoveTest < ActiveSupport::TestCase

  def setup
    @empty_move = Move.new
    @valid_move = moves(:valid)
    @draw_move = moves(:draw)
    @not_draw_move = moves(:not_draw)
    @play = plays(:one)
    @player = players(:nick)
    @opponent = players(:computer)
  end

  test 'is invalid move' do
    assert_not @empty_move.save
  end

  test 'is valid move' do
    assert @valid_move.save
  end

  test 'move not completed' do
    @valid_move.player_choice = "rock"
    @valid_move.save
    assert_not @valid_move.completed?
  end

  test 'move completed' do
    @valid_move.player_choice = "rock"
    @valid_move.opponent_choice = "paper"
    @valid_move.save
    assert @valid_move.completed?
  end

  test 'move is a draw' do
    @draw_move.save
    assert @valid_move.draw?
  end

  test 'move is not a draw' do
    @not_draw_move.save
    assert_not @not_draw_move.draw?
  end

end