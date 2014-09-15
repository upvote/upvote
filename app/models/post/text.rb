module Post
  class Text < Post::Base
    validates :description, presence: true
  end
end
