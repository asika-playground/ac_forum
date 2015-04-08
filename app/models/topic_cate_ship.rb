class TopicCateShip < ActiveRecord::Base

    belongs_to :topics
    belongs_to :categories
end
