class ChangeFriendshipIdNames < ActiveRecord::Migration[7.0]
  def up
    rename_column :friendships, :user_id, :sender_id
    rename_column :friendships, :friend_id, :receiver_id
  end

  def down
    rename_column :friendships, :sender_id, :user_id
    rename_column :friendships, :receiver_id, :friend_id
  end
end
