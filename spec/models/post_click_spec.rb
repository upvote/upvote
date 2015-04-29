require 'rails_helper'

RSpec.describe PostClick, type: :model do
  let(:post) { create :post }
  it 'updates the posts counter cache after creation' do
    expect { PostClick.create! post: post }.to change { post.clicks_count }.from(0).to(1)
  end
end
