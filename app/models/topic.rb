class Topic < ActiveRecord::Base
    belongs_to :user

    has_many :comments
    has_many :topic_cate_ships
    has_many :categories, :through => :topic_cate_ships
end
