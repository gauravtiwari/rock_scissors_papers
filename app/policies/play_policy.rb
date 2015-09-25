class PlayPolicy < ApplicationPolicy
  def update?
    current_user == record.player
  end

  def show?
    current_user == record.player || current_user == record.opponent
  end
end