class MovesController < ApplicationController

  before_action :set_move, only: [:show, :edit, :update, :destroy]
  before_action :set_play

  # GET /play/:id/moves/1
  # GET /play/:id/moves/1.json
  def show
  end

  # POST /play/:id/moves
  # POST /play/:id/moves.json
  def create
    return render json: {error: "Game closed. Play another"}, status: 200 if @play.completed?
    Move.transaction do
      #Unless play completed allow update/create
      if @play.last_move_id.value.present? and !Move.find(@play.last_move_id.value).completed?
        if @play.not_played_by?(current_player)
          update #call update
        else
          render json: { error: "Already played, Wait for Opponent to finish."}
        end
      else
        @move = Move.new(move_params)
        @move.update_attributes(play: @play, player: @play.player, opponent: @play.opponent)
        #Save the move and set play last move value to @move.id
        if @move.save
          @play.last_move_id.value = @move.id
          #Sync moves
          Pusher.trigger_async("play_#{@play.id}",
            "sync_moves",
            {
              data:  render(:show)
            }
          )
        else
          render json: { error: @move.errors },  status: :unprocessable_entity
        end
      end
    end
  end

  private

  def update
    @move = Move.find(@play.last_move_id.value)
    #Check with policy if user authorized
    MovePolicy::Scope.new(current_player, @move).resolve
    #Set choice
    @play.opponent?(current_player) ?
    @move.opponent_choice = params[:move][:opponent_choice] :
    @move.player_choice = params[:move][:player_choice]

    #Save the move and set it's last move value to nil and increment counters
    if @move.save
      #Find winner and assign
      @move.update_attributes(winner: FindMoveWinnerService.new(@move).execute) unless @move.draw?
      if @move.completed?
        #Set counters
        @play.last_move_id.value = nil
        @play.moves_count.increment
        @move.winner == @move.player ? @play.player_score.increment : @play.opponent_score.increment
      end
      #Sync moves
      Pusher.trigger_async("play_#{@play.id}",
        "sync_moves",
        {
          data:  render(:show)
        }
      )
    else
      render json: {error: @move.errors},  status: :unprocessable_entity
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_move
    @move = Move.find(params[:id])
  end

  def set_play
    @play = Play.includes(:opponent, :player).find(params[:play_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def move_params
    params.require(:move).permit(:player_choice, :opponent_choice)
  end
end
