class User < ActiveRecord::Base
  # Remember to create a migration!
  def tweet(status)
    Tweetworker.perform_async(self.id, status)
  end 
end
