helpers do
  def consumer
    @consumer ||= OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET, :site => "https://api.twitter.com")
  end
end
