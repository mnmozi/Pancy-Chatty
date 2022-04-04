
module ElasticsearchIndexer
extend ActiveSupport::Concern
included do
    after_commit :reindex_model
    def reindex_model
    return if self.previous_changes.keys.blank?
        puts self.id
        puts self.class.name
        ElasticsearchWorkerJob.perform_async(self.id,  self.class.name)
    end
end
end