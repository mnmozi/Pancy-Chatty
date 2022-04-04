class ChangeChatCountDefault < ActiveRecord::Migration[6.1]
  def change
    change_column :apps, :chatCount, :integer, default: 0
  end
end
