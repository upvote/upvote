module Post
  class Base < ActiveRecord::Base
    extend FriendlyId
    friendly_id :title, use: :slugged

    validate :acceptable?

    def acceptable?
      self.class.acceptable? url
    end

    self.table_name = :posts

    acts_as_taggable

    belongs_to :user
    has_many :clicks, class_name: 'PostClick'

    validates :title, presence: true
    validates :user_id, presence: true
    validates :user, presence: true

    acts_as_votable
    acts_as_commentable

    def self.acceptable?
      false
    end

  end
end
