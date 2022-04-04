class App < ApplicationRecord
    validates :name, presence: true, length: { minimum: 3 },uniqueness: true
    has_many :chats
end
