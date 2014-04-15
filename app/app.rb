module Blog
  class App < Padrino::Application
require 'geocoder'
require "geocoder/railtie"
  Geocoder::Railtie.insert
  register WillPaginate::Sinatra
  #register Sinatra::Contrib
  register SassInitializer
  use ActiveRecord::ConnectionAdapters::ConnectionManagement
  register Sinatra::Twitter::Bootstrap::Assets
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers
  register Padrino::Admin::AccessControl
  register Padrino::Flash
  register Padrino::Cookies
  register Padrino::FormErrors
  require 'will_paginate/array'
  #register Blog::Admin
#  register Padrino::Warden
   # require 'rack-ssl-enforcer'
    #use Rack::SslEnforcer
 enable :sessions 
=begin
use Rack::Session::Cookie, :key => '_rack_session',
                           :path => '/',
                           :expire_after => 2592000, # In seconds
                           :secret => settings.session_secret
=end                           
require 'dotenv'
Dotenv.load
=begin
require 'thinking-sphinx'
ActiveSupport.on_load :active_record do
include ThinkingSphinx::ActiveRecord
end
=end
require 'will_paginate'
require 'dalli'
set :cache, Padrino::Cache::Store::Memcache.new(::Dalli::Client.new('127.0.0.1:11211', :exception_retry_limit => 1,:expires_in=>0))
#dc.set('abc', 123)
#value = dc.get('abc')



    ##
    # Caching support.
    #
    # register Padrino::Cache
    # enable :caching
    #
    # You can customize caching store engines:
    #
    # set :cache, Padrino::Cache::Store::Memcache.new(::Memcached.new('127.0.0.1:11211', :exception_retry_limit => 1))
    # set :cache, Padrino::Cache::Store::Memcache.new(::Dalli::Client.new('127.0.0.1:11211', :exception_retry_limit => 1))
    # set :cache, Padrino::Cache::Store::Redis.new(::Redis.new(:host => '127.0.0.1', :port => 6379, :db => 0))
    # set :cache, Padrino::Cache::Store::Memory.new(50)
    # set :cache, Padrino::Cache::Store::File.new(Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
    #

    ##
    # Application configuration options.
    #
    # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
    # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, 'foo/bar' # Location for static assets (default root/public)
    # set :reload, false            # Reload application files (default in development)
    # set :default_builder, 'foo'   # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, 'bar'       # Set path for I18n translations (default your_apps_root_path/locale)
    # disable :sessions             # Disabled sessions by default (enable if needed)
    # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
     layout  :application            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #

    ##
    # You can configure for a specified environment like:
    #
    #   configure :development do
    #     set :foo, :bar
    #     disable :asset_stamp # no asset timestamping for dev
    #   end
    #

    ##
    # You can manage errors like:
    #
       error 404 do
         render 'errors/404'
       end
    #
       error 505 do
         render 'errors/505'
       end
    #
     #
     access_control.roles_for :any do |role|
      role.project_module :posts, '/logins'
      role.project_module :blog, '/'
      role.project_module :comments, '/comments/show'

     end

     access_control.roles_for :user do |role|
      role.project_module :comments, '/comments/create'
      role.project_module :comments, '/comments/new'
      role.project_module :recipes, '/recipes'

     end
    access_control.roles_for :admin do |role|
    end
    error(403) { @title = "Error 403"; render('errors/403', :layout => :error) }
    error(404) { @title = "Error 404"; render('errors/404', :layout => :error) }
    error(500) { @title = "Error 500"; render('errors/500', :layout => :error) }
  end
end
