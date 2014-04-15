#
#bundle exec puma -b 'ssl://127.0.0.1:9292?key=public/ssl/server.key&cert=public/ssl/server.crt' 
source 'https://rubygems.org'
#source 'http://production.cf.rubygems.org' 


gem 'rake', '>=10.2.2'

# Component requirements
gem 'will_paginate', '~>3.0'
gem 'haml'
gem 'activerecord', '>= 3.1', :require => 'active_record'
gem 'padrino-form-errors'
gem 'sqlite3'
# Test requirements
gem 'shoulda', :group => 'test'
gem 'rack-test', :require => 'rack/test', :group => 'test'

# Padrino Stable Gem
gem 'padrino', '0.11.4'
gem 'puma'
gem 'carrierwave'
gem  'mini_magick'
group :development, :test do
  gem 'tux'
  gem 'ffaker'
  gem 'pry'
  gem 'pry-padrino'
  gem 'pry-theme'
end
gem 'sass'
gem "sinatra-contrib"
gem 'rack-mobile-detect' 
gem 'sinatra-twitter-bootstrap', :require => 'sinatra/twitter-bootstrap'
gem 'ripl-rack', '~>0.2.1'
gem 'padrino-warden'
gem 'padrino-flash'
gem 'dotenv'
gem 'bcrypt'
#gem 'thinking-sphinx', '~> 3.0.2',
#  :require => 'thinking_sphinx/sinatra'
gem 'padrino-contrib'
gem 'kgio'
gem 'dalli'
gem 'fistface'
gem 'padrino-cookies'
gem 'rack-ssl-enforcer'
gem 'geocoder'
gem 'will_paginate-bootstrap'
# Or Padrino Edge
# gem 'padrino', :github => 'padrino/padrino-framework'

# Or Individual Gems
# %w(core gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.11.4'
# end
