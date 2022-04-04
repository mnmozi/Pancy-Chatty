class ChangeMsgCountDefault < ActiveRecord::Migration[6.1]
  def change
    change_column :chats, :msgCount, :integer, default: 0
  end
end
