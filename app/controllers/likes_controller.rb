class LikesController < ApplicationController
  before_action :set_article_like, only: %i(create destroy)

  def create
    @like = current_user.likes.new(article_id: @article.id, user_id: current_user.id)
    @like.save
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, article_id: @article.id)
    # binding.pry
    @like.destroy
  end

  
  private
  def set_article_like
      @article = Article.find(params[:id])
  end

end
