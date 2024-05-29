class SearchesController < ApplicationController
  def create
    user_id = params[:user_id]
    search_term = params[:term]
    ip = request.remote_ip

    $redis.rpush("user:#{user_id}:searches", search_term)
    SearchProcessorJob.set(wait: 1.minute).perform_later(user_id, search_term, ip)

    render json: { status: 'ok' }
  end

  def analytics
    @searches = Search.group(:term).count
  end
end
