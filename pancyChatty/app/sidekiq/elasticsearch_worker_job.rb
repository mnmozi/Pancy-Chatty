class ElasticsearchWorkerJob
  include Sidekiq::Worker
  def perform(id, klass)
    begin
      puts id
      puts klass
      puts klass.constantize.find(id.to_s).as_json()
      klass.constantize.find(id.to_s).reindex
      
    rescue => e
      # Handle exception
    end
  end
 end
