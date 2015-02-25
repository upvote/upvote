module Post
  class Base < ActiveRecord::Base
    extend FriendlyId
    friendly_id :title, use: :slugged

    self.table_name = :posts

    acts_as_taggable

    belongs_to :user
    has_many :clicks, class_name: 'PostClick', foreign_key: :post_id

    validates :title, presence: true
    validates :user_id, presence: true
    validates :user, presence: true

    acts_as_votable
    acts_as_commentable

    scope :on_date, ->(date) { where 'posts.created_at > ? AND posts.created_at < ?', date, date + 1.day }
  end
end
