class ApplicationController < ActionController::Base

  #Include pundit for authorization
  include Pundit
  protect_from_forgery with: :exception

  #Rescure from not authorized error //temporary
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

end
