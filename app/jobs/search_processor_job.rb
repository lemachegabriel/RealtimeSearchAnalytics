class SearchProcessorJob < ApplicationJob
  queue_as :default

  def perform(user_id, search_term, ip)
    redis_key = "user:#{user_id}:searches"
    searches = $redis.lrange(redis_key, 0, -1)
    $redis.del(redis_key)

    final_search = searches.last
    Search.create!(term: final_search, ip: ip, user_id: user_id)
  end
end
