class User < ActiveRecord::Base
  extend FriendlyId

  devise :trackable, :omniauthable, omniauth_providers: [:twitter,:github]

  has_many :authorizations
  has_many :clicks, class_name: 'PostClick'
  has_many :posts

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX  = /\A#{TEMP_EMAIL_PREFIX}/

  validates :email, format: { without: TEMP_EMAIL_REGEX }, on: :update
  validates :headline, presence: true, on: :update
  validates :name,     presence: true

  serialize :meta, JSON

  acts_as_voter

  friendly_id :name, use: :slugged

  def first_authorization
    authorizations.first
  end

  delegate :handle, to: :first_authorization, allow_nil: true

  # def handle
  #   github_handle || twitter_handle
  # end
  #
  # def github_handle
  #   "@#{authorizations.where(provider:'github').first.handle}"
  # rescue
  #   nil
  # end
  #
  # def twitter_handle
  #   "@#{authorizations.where(provider:'twitter').first.handle}"
  # rescue
  #   nil
  # end

  def self.find_for_oauth(auth, signed_in_resource = nil)0
    # Get the identity and user if they exist
    identity = Authorization.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      # email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      
      email = auth.info.email # if email_is_verified
      user  = User.where(email:email).first if email
      image = auth.extra.raw_info.profile_image_url_https || auth.info.image

      # Create the user if it's a new registration
      if user.nil?
        user_attrs = {
          name: auth.extra.raw_info.name,
          avatar: image,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          meta: auth.extra.raw_info.to_h }
        user = User.new(user_attrs)
        # user.skip_confirmation!
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end

    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

end
