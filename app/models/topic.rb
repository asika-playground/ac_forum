class Topic < ActiveRecord::Base
    belongs_to :user

    has_many :comments
    has_many :topic_cate_ships
    has_many :categories, :through => :topic_cate_ships

    before_create :get_time_now

    validates_presence_of :title, :content

    # def last_update
    #   if self.comment_ids.size > 0
    #     self.comments.last.updated_at
    #   else
    #     self.updated_at
    #   end
    # end

    def users_unique
      users_uq = [self.user]
      self.comments.each do |c|
        users_uq << c.user
      end

      return users_uq.uniq
    end

    protected

    def get_time_now
      self.last_update = Time.now
    end
end
