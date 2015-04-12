class Topic < ActiveRecord::Base
    belongs_to :user

    has_many :comments
    has_many :topic_cate_ships
    has_many :categories, :through => :topic_cate_ships

    def last_update
      if self.comment_ids.size > 0
        self.comments.last.updated_at
      else
        self.updated_at
      end
    end
end
