module Post
  class Base < ActiveRecord::Base
    extend FriendlyId
    friendly_id :title, use: :slugged

    self.table_name = :posts

    belongs_to :user
    has_many :clicks, class_name: 'PostClick'

    validates :title, presence: true
    validates :user_id, presence: true
    validates :user, presence: true

    acts_as_votable
    acts_as_commentable
  end
end
