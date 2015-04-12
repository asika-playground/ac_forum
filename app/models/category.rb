class Category < ActiveRecord::Base

    has_many :topic_cate_ships
    has_many :topics, :through => :topic_cate_ships

    validates_presence_of :name
end
