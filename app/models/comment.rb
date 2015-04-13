class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :topic, :counter_cache => true, :touch => true

    after_create :update_topic

    protected

    def update_topic
      self.topic.update_attribute(:updated_at, self.updated_at)
    end
end
