source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 6.1.3'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'simple_form'
gem 'image_processing', '~> 1.2'
gem 'devise', :git => "https://github.com/heartcombo/devise.git", ref: '8bb358cf80a632d3232c3f548ce7b95fd94b6eb2'
gem 'devise-bootstrap-views', '~> 1.0'
gem 'friendly_id', '~> 5.4.0'
gem 'ransack'
gem "rolify"
gem "pundit"

group :development, :test do
    gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
    gem 'faker'
end

group :development do
    gem 'web-console', '>= 4.1.0'
      gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
    gem 'spring'
end

group :test do
    gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
    gem 'webdrivers'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
