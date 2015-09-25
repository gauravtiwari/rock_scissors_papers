class MessagesController < ApplicationController
  before_action :authenticate_player!
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /play/1/messages
  # GET /play/1/messages.json
  def index
    @messages = Message.order(id: :desc)
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # POST /play/1/messages
  # POST /play/1/messages.json
  def create
    @message = Message.new(message_params)
    @message.play_id = params[:play_id]
    @message.sender = current_player

    #saved trigger messages to chatrooms
    if @message.save
      Pusher.trigger_async("play_#{params[:play_id]}_chat",
        "new_message",
        {
          data:  render(:show)
        }
      )
    else
      render json: @message.errors
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:body)
  end

end
