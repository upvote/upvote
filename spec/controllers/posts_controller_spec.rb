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

      context 'with invalid data' do
        subject { post :create, post: FactoryGirl.attributes_for(:post).except(:title, :url) }

        it 'does not create a post object' do
          expect { subject }.to_not change { Post::Base.count }
        end
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

    context 'with a specific tag' do
      let(:tags) { ['cool', 'lame', 'awesome', 'super cool'] }
      let(:tag)  { tags.sample }

      it 'assigns @posts to only posts with the specified tag' do
        post_object.tag_list << tag
        post_object.save!
        get :index, tag: tag
        expect(assigns :posts).to eq(post_object.created_at.to_date => [post_object])
      end

    end

    context 'with a specific date' do
      let(:random_date) { (Time.zone.today - rand(5).years - rand(365).days).to_date }
      let(:date_params) { { year: random_date.year, month: random_date.month, day: random_date.day } }

      it 'assigns @posts to only posts from that date' do
        num = rand(10) + 3
        posts = num.times.map { create :post, created_at: random_date.to_time }
        get :index, date_params
        expect(assigns :posts).to eq(random_date => posts)
      end

    end

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
