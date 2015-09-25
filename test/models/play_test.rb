require 'test_helper'

class PlayTest < ActiveSupport::TestCase

  def setup
    @empty_play ||= Play.new
    @valid_play ||= plays(:one)
  end

  test 'is invalid' do
    assert_not @empty_play.save
  end

  test 'is valid' do
    assert @valid_play.save
  end

  test 'is not completed if play moves are not completed' do
    assert_not @valid_play.completed?
  end

  test 'is not draw if play moves are not completed' do
    assert_not @valid_play.draw?
  end

end