class Message < ActiveRecord::Base
  belongs_to :play
  belongs_to :sender, class_name: 'Player', foreign_key: 'sender_id'
end
