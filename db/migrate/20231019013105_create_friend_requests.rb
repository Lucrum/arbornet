class CreateFriendRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :friend_requests do |t|
      t.integer :sender_id, foreign_key: true, null: false
      t.integer :receiver_id, foreign_key: true, null: false
      t.string :status

      t.timestamps
    end
  end
end
