source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'

###doc [2] comment sqlite3 change to pg
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'

# Use Puma as the app server
gem 'puma', '~> 3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

###doc [5] uncomment bcrypt to allow used has_secure_password
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

###doc [4] uncomment rack to handling Cross-Origin Resource Sharing (CORS) API
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  ###doc [6] set up rspec and guard
  gem 'rspec-rails', '~> 3.5'
  # then run $ rails generate rspec:install

  gem 'guard-rspec', require: false
  # then run $ bundle exec guard init rspec
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

###### CUSTOM GEM

###doc [1] set up database to pg and prepare to deploy heroku
group :production do
  gem 'pg'
  gem 'rails_12factor'
end

###doc [3] set up figaro for env
gem 'figaro'
# then run $ bundle exec figaro install

###doc [7] set up factory_girl
# DEPRECATION gem 'factory_girl_rails'
gem 'factory_bot_rails'

###doc [8] set up API grape and swagger doc
gem 'grape'
gem 'grape-middleware-logger'
gem 'grape-entity'
gem 'hashie-forbidden_attributes'

# documentation
gem 'grape-swagger'
gem 'grape-swagger-rails'