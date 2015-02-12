module Post
  class Link < Post::Base
    validates :url, presence: true
    validate :url_is_valid

    def url_is_valid
      uri = URI.parse(url)
      raise 'invalid URL' unless ( uri.protocol == 'https' || uri.protocol == 'http' )
    rescue
      errors.add :url, 'is invalid'
    end

  end
end
