require "test_helper"
class PlaysControllerTest < ActionController::TestCase

  # called before every single test
  def setup
    sign_in players(:nick), @player
    @play = plays(:one)
  end

  # called after every single test
  def teardown
    @play = nil
  end

  test "should show play" do
    get :show, id: @play.id
    assert_response :success
  end

end