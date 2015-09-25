class Player < ActiveRecord::Base

  #Include Redis
  include Redis::Objects

  #Include Devise
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #Associations
  has_many :opponent_moves, class_name: 'Move', foreign_key: 'opponent_id', dependent: :destroy
  has_many :moves

  #Redis data types to store Game and play data
  sorted_set :rank, :global => true
  counter :plays_count
  counter :wins_count
  counter :loose_count

  # Callbacks to initialize user rank
  after_commit :initialize_player_rank, on: :create
  after_commit :delete_player_rank, on: :destroy

  #Public interface methods
  public

  def name_badge
    words = name.split(' ')
    if words.length == 2
      words.first(2).map{|w| w.first }.join.upcase
    else
      characters = name.split('')
      (characters.first + characters.second).upcase
    end
  end

  def initialize_player_rank
    rank.add(id, 0)
  end

  def delete_player_rank
    rank.delete(id)
    true
  end
end
