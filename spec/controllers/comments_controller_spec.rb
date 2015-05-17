require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe '#index' do
    context 'with an invalid post' do
      it 'renders a 404 if unable to load the post' do
        get :index, post_id: 'this-does-not-exist'
        expect(response.status).to eq(404)
      end
    end
    context 'with a valid post' do
      let(:post) { create :post }
      before(:each) {
        rand(100).times { create :comment, commentable: post }
        get :index, post_id: post.slug
      }
      it 'loads the post object associated with the id' do
        expect(assigns :post).to eq(post)
      end
      it 'loads a list of comments for the post' do
        expect(assigns :comments).to eq(post.comment_threads)
      end
    end
  end
  describe '#create' do
    context 'when logged in' do
      before(:each) { sign_in create(:user) }
      it 'creates a new comment object' do
        expect {
          post :create, comment: FactoryGirl.attributes_for(:comment), post_id: create(:post).id
        }.to change(Comment,:count).by(1)
      end
    end
    context 'when logged out' do
      it 'prevents the user from commenting' do
        post :create, comment: FactoryGirl.attributes_for(:comment), post_id: create(:post).id
        expect(response.status).to eq(302)
        expect(response).to redirect_to root_url
      end
    end
  end
end
