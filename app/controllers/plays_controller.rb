class PlaysController < ApplicationController
  before_action :authenticate_player!, except: :index
  before_action :set_play, only: [:show, :edit, :update, :destroy]
  before_action :current_user

  # GET /plays
  # GET /plays.json
  def index
    @plays = Play.includes(:opponent, :player, :winner).all
  end

  # GET /plays/1
  # GET /plays/1.json
  def show
    authorize @play
  end

  # GET /plays/new
  def new
    @play = Play.new
  end

  # POST /plays
  # POST /plays.json
  def create
    @play = Play.new(play_params)
    @play.player = current_player
    respond_to do |format|
      if @play.save
        format.html { redirect_to @play, notice: 'Play was successfully created.' }
        format.json { render :show, status: :created, location: @play }
      else
        format.html { render :new }
        format.json { render json: @play.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plays/1
  # PATCH/PUT /plays/1.json
  def update
    respond_to do |format|
      if @play.update(play_params)
        format.html { redirect_to @play, notice: 'Play was successfully updated.' }
        format.json { render :show, status: :ok, location: @play }
      else
        format.html { render :edit }
        format.json { render json: @play.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plays/1
  # DELETE /plays/1.json
  def destroy
    @play.destroy
    respond_to do |format|
      format.html { redirect_to plays_url, notice: 'Play was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def current_user
      current_player
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_play
      @play = Play.includes(:player, :opponent, :winner, :messages).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def play_params
      params.require(:play).permit(:opponent_id, :min_moves)
    end
end
