require 'net/http'

http = Net::HTTP.start('stackoverflow.com')
resp = http.head('/')
resp.each { |k, v| puts "#{k}: #{v}" }
http.finish

module Post
  class Image < Post::Link

    def self.acceptable?(url)
      return false unless super(url)

      # fast shitty version
      return [ '.jpg', '.png', '.gif' ].include?(File.extname URI.parse(url).path)

      # slow legit version
      # http = Net::HTTP.start(self.url)
      # resp = http.head('/')
      # resp.each do |header,value|
      #   return value.starts_with?('image') if header == 'Content-type'
      # end
      # http.finish
      #
      # return false
    end



  end
end
