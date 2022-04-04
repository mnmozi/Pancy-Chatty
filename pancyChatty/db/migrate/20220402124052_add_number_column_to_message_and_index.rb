class AddNumberColumnToMessageAndIndex < ActiveRecord::Migration[6.1]
  def change
    add_column :chats, :number, :integer
    add_column :messages, :number, :integer
    add_index :chats, [:app_id, :number] , unique: true
    add_index :messages, [:chat_id, :number] , unique: true
  end
end
