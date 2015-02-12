module Post
  class Link < Post::Base
    validates :url, presence: true
    validate :url_is_valid

    def url_is_valid
      uri = URI.parse(url)
      raise 'invalid URL' unless ( uri.scheme == 'https' || uri.scheme == 'http' )
    rescue => e
      errors.add :url, 'is invalid'
    end

  end
end
