# Set ruby version
ruby '2.2.2'

# Gem source
source 'https://rubygems.org'

# Fetch rails assets
source 'https://rails-assets.org' do
  gem 'rails-assets-underscore'
  gem 'rails-assets-pusher'
end

#Core rails, database and server
gem 'rails', '4.2.4'
gem 'pg'
gem 'sprockets-rails'
gem 'arel'

#Server
gem 'passenger'
gem 'foreman'

#Setup bootstrap
gem 'bootstrap-sass'

#JS VM and SASS
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'jquery-rails'

#Redis
gem 'redis'
gem 'redis-namespace'
gem 'hiredis'
gem 'readthis', '~> 1.0.0.pre.beta'
gem 'connection_pool'
gem 'redis-objects'

#Authentication & authorization
gem 'devise'
gem 'devise_invitable'
gem 'pundit'

#Icons
gem 'font-awesome-rails'

#Views/JSON
gem 'jbuilder'
gem 'react-rails'

#ENV management
gem 'figaro'

#Notifications
gem 'snackbarjs-rails'

#Realtime
gem 'pusher'
gem 'em-http-request'

#Heroku
group :production do
  gem 'rails_12factor'
end

# MiniTest, Capybara suite
group :development, :test do
  gem 'byebug'
  gem 'minitest-rails'
end

group :test do
  gem "capybara"
  gem "launchy"
  gem "minitest-reporters"
  gem "mocha"
  gem "poltergeist"
  gem "shoulda"
  gem "test_after_commit"
end

# MiniTest, Guard and terminal notifier
group :development do
  gem 'web-console'
  gem 'spring'
  gem "guard", ">= 2.2.2", :require => false
  gem "guard-minitest", :require => false
  gem "rb-fsevent", :require => false
  gem "terminal-notifier-guard", :require => false
end