# require 'twitter'
# require 'oauth'

# CONSUMER_KEY = "67ZedRa4gv5u29E7KM0CQ"
# CONSUMER_SECRET = "DN8PL4Q7Crgv6S7Hg6X1NMVBXmXzF07E7kT5Ja4PQw"

# get '/' do
#   erb :index
# end

# get '/request' do
#   session[:oauth] ||= {}
#   @request_token = consumer.get_request_token(:oauth_callback => 'http://localhost:9292/oauth')
#   session[:oauth][:request_token] = @request_token.token
#   session[:oauth][:request_token_secret] = @request_token.secret
#   redirect @request_token.authorize_url
# end

# get "/oauth" do
#   @request_token = OAuth::RequestToken.new(consumer, session[:oauth][:request_token], session[:oauth][:request_token_secret])
#   @access_token = @request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
#   session[:access_token] = @access_token.token
#   session[:access_token_secret] = @access_token.secret
#   redirect '/tweet'
# end


# post '/tweet' do

#   begin
#     client = Twitter::Client.new(
      # :consumer_key => CONSUMER_KEY,
      # :consumer_secret => CONSUMER_SECRET,
#       :oauth_token => session[:access_token],
#       :oauth_token_secret => session[:access_token_secret]
#     )
#     client.update(params[:tweet])
#   rescue Twitter::Error => error
#     @error = error.wrapped_exception
#   end
#   puts @error
#   puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
#     if @error
#       @message = @error
#     else
#       @message = "Succesfully tweeted!"
#     end
#     @message
# end

# get '/tweet' do
#   erb :tweet
# end

