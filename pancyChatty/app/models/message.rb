class Message < ApplicationRecord
  include ElasticsearchIndexer
  searchkick callbacks: false
  belongs_to :chat
end
