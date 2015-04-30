require 'rails_helper'

RSpec.describe Post::Base, type: :model do
  let(:post) { create :post }

  it 'can be tagged' do
    expect do
      post.tag_list << 'awesome'
      post.save
    end.to change { post.tag_list }.from([]).to(['awesome'])
  end

end
