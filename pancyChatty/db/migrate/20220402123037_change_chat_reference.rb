class ChangeChatReference < ActiveRecord::Migration[6.1]
  def change
    rename_column :chats, :app_token, :app_id
  end
end
