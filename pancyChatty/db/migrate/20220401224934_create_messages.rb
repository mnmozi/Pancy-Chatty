class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :content
      t.references :chat, null: false, foreign_key: true

      t.timestamps
    end
    change_column :messages, :content, :string, null: false
  end
end
