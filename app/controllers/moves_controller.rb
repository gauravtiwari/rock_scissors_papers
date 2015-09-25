class MovesController < ApplicationController
  before_action :authenticate_player!
  before_action :set_move, only: [:show, :edit, :update, :destroy]
  before_action :set_play

  # GET /play/:id/moves/1
  # GET /play/:id/moves/1.json
  def show
    #render show
  end

  # POST /play/:id/moves
  # POST /play/:id/moves.json
  def create
    return render json: {error: "Game closed. Play another"}, status: 200 if @play.completed?
    # Wrap the transaction in a block to avoid race conditions
    Move.transaction do
      #Unless play completed allow update/create
      if @play.last_move_id.value.present? and !Move.find(@play.last_move_id.value).completed?
        if @play.not_played_by?(current_player)
          update #call update
        else
          render json: { error: "Already played, wait for opponent to finish."}
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
      #Check with policy if user authorized player || opponent
      authorize @move

      #Set choice
      @play.opponent?(current_player) ?
        @move.opponent_choice = params[:move][:opponent_choice] :
        @move.player_choice = params[:move][:player_choice]

      #Save the move and set it's last move value to nil and increment counters
      if @move.save

        #Find winner and update
        @move.update_attributes(winner_id: FindMoveWinnerService.new(@move).execute) unless @move.draw?

        # Set last move to nil //if move completed
        if @move.completed?
          #Set counters
          @play.last_move_id.value = nil
          @play.moves_count.increment
        end

        # Increment player score unless draw
        if !@move.draw?
          @move.winner == @move.player ?
            @play.player_score.increment :
            @play.opponent_score.increment
        end

        #Update play
        if @play.completed? and !@play.draw?
          @play.update_attributes(winner_id: @play.winning_player_id,
          looser_id: @play.loosing_player_id)
        end

        #Sync moves between players
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

    #Set current user
    def current_user
      current_player
    end

    # Set move in callbacks
    def set_move
      @move = Move.includes(:player, :opponent, :winner, :play).find(params[:id])
    end

    # Set move in callbacks
    def set_play
      @play = Play.includes(:opponent, :player, :winner).find(params[:play_id])
    end

    # permitted params
    def move_params
      params.require(:move).permit(:player_choice, :opponent_choice)
    end

end
