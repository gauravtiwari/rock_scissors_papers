class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.references :play, index: true, foreign_key: true
      t.references :player, index: true, foreign_key: true, null: false
      t.integer :opponent_id, index: true, foreign_key: true, class_name: "Player", null: false
      t.integer :winner_id, index: true, foreign_key: true, class_name: "Player"
      t.string :player_choice
      t.string :opponent_choice
      t.timestamps null: false
    end
    add_index :moves, [:play_id, :player_id, :player_choice]
    add_index :moves, [:play_id, :opponent_id, :opponent_choice]
    add_index :moves, [:play_id, :winner_id]
  end
end
