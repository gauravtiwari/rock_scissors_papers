class CreatePlays < ActiveRecord::Migration
  def change
    create_table :plays do |t|
      t.references :player, index: true, foreign_key: true
      t.integer :opponent_id, index: true, foreign_key: true, class_name: "Player"
      t.integer :winner_id, index: true, foreign_key: true, class_name: "Player"
      t.integer :looser_id, index: true, foreign_key: true, class_name: "Player"
      t.integer :min_moves, index: true, default: 3
      t.timestamps null: false
    end
  end
end
