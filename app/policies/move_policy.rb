class MovePolicy < ApplicationPolicy
  def create?
    current_user == record.player || current_user == record.opponent
  end
end