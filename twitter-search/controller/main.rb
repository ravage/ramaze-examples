class MainController < Ramaze::Controller
  layout :master

  def index
    if request.post?
      feed = Feedzirra::Feed.fetch_and_parse("http://search.twitter.com/search.atom?q=#{request[:query]}")
      @entries = feed.entries
    end
  end
end