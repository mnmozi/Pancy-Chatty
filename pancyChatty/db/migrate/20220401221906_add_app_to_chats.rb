class AddAppToChats < ActiveRecord::Migration[6.1]
  def change
    add_reference :chats, :app, null: false, foreign_key: true
  end
end
