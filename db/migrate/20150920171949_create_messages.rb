class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :play, index: true, foreign_key: true
      t.integer :sender_id, index: true, class_name: 'Player', foreign_key: true
      t.text :body

      t.timestamps null: false
    end
  end
end
