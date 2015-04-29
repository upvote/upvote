require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let(:user) { create :user }

  describe '#about' do
    subject { get :about }

    it 'renders the about.html.slim template' do
      expect(subject).to render_template('pages/about')
    end
  end

  describe '#login' do
    subject { get :login }

    context 'when logged out' do
      it 'renders the login.html.slim template' do
        expect(subject).to render_template('pages/login')
      end
    end
    context 'when logged in' do
      before(:each) { sign_in user }
      it 'redirects back to the home page' do
        subject
        expect(response).to redirect_to('/')
      end
    end
  end

  describe '#terms_of_service' do
    subject { get :terms_of_service }

    it 'renders the terms_of_service.html.slim template' do
      expect(subject).to render_template('pages/terms_of_service')
    end
  end

  describe '#privacy_policy' do
    subject { get :privacy_policy }

    it 'renders the privacy_policy.html.slim template' do
      expect(subject).to render_template('pages/privacy_policy')
    end
  end

end
