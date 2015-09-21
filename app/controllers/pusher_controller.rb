class PusherController < ApplicationController
  before_filter :authenticate_player!
  protect_from_forgery :except => :auth

  def auth
    if current_player
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
        :user_id => current_player.id,
        :player_info => {
          :user_id => current_player.id,
          :name => current_player.name,
          :name_badge => current_player.name_badge,
          :email => current_player.email,
          :url => player_path(current_player)
        }
      })
      render :json => response
    else
      render :text => "Not authorized", :status => '403'
    end
  end
end