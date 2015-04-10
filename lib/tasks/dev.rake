namespace :dev do

  task :fake => :environment do
    user = User.first

    100.times do |i|
      # Event.create( :name => "Event #{i}", :user => user)

      category_ids = []

      (0..rand(Category.all.count)).each do
        category_ids << rand(Category.all.count)+1
      end
      category_ids = category_ids.uniq

      Topic.create(
          :title => Faker::Name.title,
          :content => Faker::Lorem.sentence(144, false, 4),
          :user_id => 1,
          :category_ids => category_ids
        )
    end
  end

end