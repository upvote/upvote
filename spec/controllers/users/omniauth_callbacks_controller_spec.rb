require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  before(:each) { request.env["devise.mapping"] = Devise.mappings[:user] }

  describe 'provider callbacks' do
    context 'with a new user' do

      context 'when the email is supplied by the provider' do
        let(:auth_hash) { OmniAuth::AuthHash.new uid: SecureRandom.uuid, provider: 'facebook', email: Faker::Internet.email }
        before(:each) {
          OmniAuth.config.mock_auth[:facebook] = auth_hash
          request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
        }

        it 'creates a new user object' do
          pending 'omniauth rspec setup'
          expect { post :facebook }.to change(User,:count).by(1)
        end

        it 'creates a new authorization object' do
          pending 'omniauth rspec setup'
          expect { post :facebook }.to change(Authorization,:count).by(1)
        end

        it 'redirects to the root page' do
          pending 'omniauth rspec setup'
          post :facebook
          expect(response).to redirect_to(root_path)
        end

      end

      context 'when the email is NOT supplied by the provider' do
        let(:auth_hash) { OmniAuth::AuthHash.new uid: SecureRandom.uuid, provider: 'twitter' }
        before(:each) {
          OmniAuth.config.mock_auth[:twitter] = auth_hash
          request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
        }

        it 'asks the user for their email' do
          pending 'omniauth rspec setup'
          post :twitter
          expect(response).to redirect_to(finish_signup_user_path(:user))
        end

      end

    end


    it 'creates a new user object' do
      pending 'omniauth rspec setup'
      expect { post :facebook }.to change(User,:count).by(1)
    end

  end

  describe '#log_out' do
    context 'when logged in' do
      it 'logs the user out' do
        delete :log_out
        expect(response).to redirect_to(root_path)
      end
    end
    context 'when logged out' do
    end
  end
end
