module Post
  class Text < Post::Base
    validates :description, presence: true

    def self.acceptable?
      true # we can handle anything!
    end

  end
end
