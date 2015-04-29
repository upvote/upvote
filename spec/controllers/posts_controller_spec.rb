require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user)        { create :user }
  let(:post_object) { create :post }

  describe '#new' do
    subject { get :new }

    context 'when logged in' do
      before(:each) { sign_in user }
      it 'renders the new post form' do
        expect(subject).to render_template('posts/new')
      end
    end

    context 'when logged out' do
      it 'reponds with a redirect to login' do
        subject
        expect(response).to have_http_status(302)
      end
    end
  end

  describe '#create' do
    subject { post :create, post: FactoryGirl.attributes_for(:post) }

    context 'when logged in' do
      before(:each) { sign_in user }
      it 'creates a post object' do
        expect { subject }.to change { Post::Base.count }.by(1)
      end
    end

    context 'when logged out' do
      it 'reponds with a redirect to login' do
        subject
        expect(response).to have_http_status(302)
      end
    end
  end

  describe '#index' do
    subject { get :index }

    it 'should assign @posts' do
      subject
      expect(assigns :posts).not_to be_nil
    end

    it 'should render the index template' do
      expect(subject).to render_template('posts/index')
    end
  end

  describe '#submitted_by_user' do
    subject { get :submitted_by_user, user_id: post_object.user.slug }

    it 'should assign @posts to all posts submitted by a user' do
      subject
      expect(assigns :posts).to eq(post_object.user.posts)
    end
  end

  describe '#liked_by_user' do
    subject { get :liked_by_user, user_id: user.slug }

    it 'assigns @posts to all posts upvoted by a user' do
      posts = 5.times.map { create :post }
      posts.each { |pst| user.up_votes pst }
      subject
      expect(assigns :posts).to eq(posts)
    end
  end

  describe '#upvote' do
    subject { post :upvote, id: post_object.slug }

    context 'when logged in' do
      before(:each) { sign_in user }

      it 'increments the votes for an object' do
        expect { subject }.to change { post_object.get_upvotes.count }.by(1)
      end
    end

    context 'when logged out' do
      it 'responds with a redirect to login' do
        subject
        expect(response).to have_http_status(302)
      end
    end
  end

  describe '#outbound' do
    subject { get :outbound, id: post_object.id }

    it 'creates a PostClick object' do
      expect { subject }.to change { post_object.clicks.count }.by(1)
    end

    context 'when logged in' do
      before(:each) { sign_in user }
      it 'creates a PostClick object with associated to the current user' do
        subject
        expect(post_object.clicks.last.user).not_to be_nil
        expect(post_object.clicks.last.user).to eq(user)
      end
    end
  end

end
