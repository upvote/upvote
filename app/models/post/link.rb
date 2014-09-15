module Post
  class Link < Post::Base
    validates :url, presence: true
  end
end
