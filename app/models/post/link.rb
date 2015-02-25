module Post
  class Link < Post::Base
    validates :url, presence: true
    validate :url_is_valid

    def url_is_valid
      uri = URI.parse(url)
      fail 'invalid URL' unless uri.scheme == 'https' || uri.scheme == 'http'
    rescue
      errors.add :url, 'is invalid'
    end
  end
end
