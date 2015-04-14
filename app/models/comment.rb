class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :topic, :counter_cache => true, :touch => true

    validates_presence_of :content

    def can_delete_by?(user)
      (self.user == user) || (self.user.admin?)
    end
end
