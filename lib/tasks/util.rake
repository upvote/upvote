namespace :util do
  if defined?(Faker)
    namespace :fake do
      desc 'populate the environment with a bunch of fake users'
      task users: :environment do
        rand(100).times do
          name = Faker::Name.name
          user = User.create! name: Faker::Name.name,
                              email: Faker::Internet.email,
                              headline: "#{Faker::Name.title}, #{Faker::Company.name}",
                              avatar: Faker::Avatar.image(name.parameterize, '48x48')
          datetime = Time.now - rand(50).days - rand(24).hours - rand(1440).minutes
          user.update_attributes created_at: datetime, updated_at: datetime
        end
      end

      desc 'populate the environment with a bunch of fake posts'
      task posts: :environment do
        rand(100).times do
          post = Post::Base.create! title: Faker::Company.name,
                                    description: Faker::Company.catch_phrase,
                                    url: Faker::Internet.url,
                                    user: User.order('RANDOM()').first
          datetime = Time.now - rand(10).days - rand(24).hours - rand(1440).minutes
          post.update_attributes created_at: datetime, updated_at: datetime
        end
      end

      desc 'populate the environment with a bunch of fake upvotes'
      task upvotes: :environment do
        rand(User.count * Post::Base.count).times do
          user = User.order('RANDOM()').first
          post = Post::Base.order('RANDOM()').first
          post.liked_by user
        end
      end

      desc 'populate the environment with a bunch of fake comments'
      task comments: :environment do
        rand(500).times do
          post = Post::Base.order('RANDOM()').first
          comment = post.comment_threads.create! \
            body: Faker::Lorem.paragraphs(1 + rand(3)).join("\n\n"),
            user: User.order('RANDOM()').first
          datetime = post.created_at - rand(10).days - rand(24).hours - rand(1440).minutes
          comment.update_attributes created_at: datetime, updated_at: datetime
        end
      end
    end
  end
end
