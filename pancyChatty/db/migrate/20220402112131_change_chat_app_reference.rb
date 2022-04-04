class ChangeChatAppReference < ActiveRecord::Migration[6.1]
  def change
    rename_column :chats, :app_id, :app_token
  end
end
