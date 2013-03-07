# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'
require 'redis'
require 'sidekiq'
require 'twitter'

require 'sinatra'
# require "sinatra/reloader" if development?

require 'erb'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

Twitter.configure do |config|
  config.consumer_key = "67ZedRa4gv5u29E7KM0CQ"
  config.consumer_secret = "DN8PL4Q7Crgv6S7Hg6X1NMVBXmXzF07E7kT5Ja4PQw"
end

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'workers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')


# $client = Twitter::Client.new(
#       :consumer_key => CONSUMER_KEY,
#       :consumer_secret => CONSUMER_SECRET,
#       :oauth_token => user.access_token,
#       :oauth_token_secret => user.access_token_secret
#       )

# $client.update(params[:tweet])
