require 'twitter'
require 'oauth'

CONSUMER_KEY = "67ZedRa4gv5u29E7KM0CQ"
CONSUMER_SECRET = "DN8PL4Q7Crgv6S7Hg6X1NMVBXmXzF07E7kT5Ja4PQw"


get '/' do
  erb :index
end

get '/request' do
  session[:oauth] ||= {}
  @request_token = consumer.get_request_token(:oauth_callback => 'http://localhost:9292/oauth')
  session[:oauth][:request_token] = @request_token.token
  session[:oauth][:request_token_secret] = @request_token.secret
  redirect @request_token.authorize_url
end

get "/oauth" do
  puts "something else"
  @request_token = OAuth::RequestToken.new(consumer, session[:oauth][:request_token], session[:oauth][:request_token_secret])
  @access_token = @request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  @user = User.new(:access_token => @access_token.token, :access_token_secret => @access_token.secret)
  p @access_token
  @user.save
  session[:user_id] = @user.id
  logger.info "hello I am in oauth"
  logger.info "====================================================="
  # session[:access_token] = @access_token.token
  # session[:access_token_secret] = @access_token.secret
  redirect '/tweet'
end


post '/tweet' do
  content_type :json
  user = User.find(session[:user_id])
  job_id = TweetWorker.perform_async(user.access_token, user.access_token_secret, params[:tweet])
  {:job_id => job_id}.to_json
end

get '/tweet' do
  erb :tweet
end

get '/status/:job_id' do
  queue = Sidekiq::Queue.new('default')
  if queue.find { |job| job.jid == params[:job_id] }
    true
    # job is still in queue and therefore not completed
  else
    false
    # job is no longer in queue
  end
end
