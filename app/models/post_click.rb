class PostClick < ActiveRecord::Base
  belongs_to :post, counter_cache: :clicks_count, class_name: 'Post::Base'
  belongs_to :user
  validates :post,    presence: true
  validates :post_id, presence: true
end
