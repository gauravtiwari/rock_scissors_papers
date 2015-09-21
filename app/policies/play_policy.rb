class PlayPolicy < ApplicationPolicy
  def update?
    current_player == record.player
  end
end