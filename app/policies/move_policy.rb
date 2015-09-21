class MovePolicy < ApplicationPolicy
  def update?
    current_player == record.player || current_player == record.opponent
  end
end