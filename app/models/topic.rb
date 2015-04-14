class Topic < ActiveRecord::Base
    belongs_to :user

    has_many :comments
    has_many :topic_cate_ships
    has_many :categories, :through => :topic_cate_ships

    before_create :get_time_now

    validates_presence_of :title, :content

    def can_delete_by?(user)
      (self.user == user) || (self.user.admin?)
    end

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
