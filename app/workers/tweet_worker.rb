class TweetWorker
  include Sidekiq::Worker

  def perform(access_token, access_token_secret, tweet)

    begin
      client = Twitter::Client.new(
        :oauth_token => access_token,
        :oauth_token_secret => access_token_secret
      )
      client.update(tweet)
    rescue Twitter::Error => error
      @error = error.wrapped_exception
    end
  end
end
