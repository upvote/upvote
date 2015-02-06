module Post
  class Link < Post::Base
    validates :url, presence: true

    def self.acceptable?(url)
      url ~= /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/
    end

  end
end
