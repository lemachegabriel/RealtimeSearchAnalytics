class SearchesController < ApplicationController
  def create
    user_id = params[:user_id]
    search_term = params[:term]
    ip = request.remote_ip

    unless search_term.empty?
      $redis.rpush("user:#{user_id}:searches", search_term)
      SearchProcessorJob.set(wait: 30.seconds).perform_later(user_id, search_term, ip)
    end

    @articles = Article.where("LOWER(title) LIKE ?", "%#{search_term.downcase}%")
    render json: @articles
  end

  def analytics
    @searches = Search.group(:term).count
  end
end
