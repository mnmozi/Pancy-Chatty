class AddTokenToApp < ActiveRecord::Migration[6.1]
  def change
    add_column :apps, :token, :string
    add_index :apps, :token
  end
end
