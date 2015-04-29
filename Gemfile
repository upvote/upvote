source 'https://rubygems.org'

ruby '2.2.1'

gem 'rails', github: 'rails/rails', branch: '4-2-stable'
gem 'sprockets'
gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'puma'

gem 'omniauth-twitter'
gem 'omniauth-github'
gem 'omniauth-facebook'

gem 'typekit-rails'
gem 'awesome_nested_set',                 github: 'collectiveidea/awesome_nested_set'
gem 'acts_as_commentable_with_threading', github: 'elight/acts_as_commentable_with_threading'
gem 'acts_as_votable'
gem 'slim'
gem 'font-awesome-sass'
gem 'bourbon'
gem 'refills'
gem 'bitters'
gem 'neat'
gem 'gravatar_image_tag'
gem 'devise',              github: 'plataformatec/devise'
gem 'friendly_id',         github: 'norman/friendly_id'
gem 'acts-as-taggable-on', github: 'mbleigh/acts-as-taggable-on'

# this will go into the development group.... later ;)
gem 'faker'

gem 'rspec-rails', group: [:development, :test]

group :test do
  gem 'simplecov', require: false
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'faker'
end

group :development do
  gem 'quiet_assets'
  gem 'spring'
  gem 'sqlite3'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'awesome_print'
end

group :production do
  gem 'rails_12factor'
  gem 'pg'
end
