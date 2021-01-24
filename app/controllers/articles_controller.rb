class ArticlesController < ApplicationController
  def index
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    unless @article.valid?
      flash[:notice] = @article.errors.full_messages
      render :new
      return
    end
    @article.save
    redirect_to root_url
  end

  private

  def article_params
    params.require(:article).permit(:title, :thumbnail, :abstract, :body).merge(user_id: current_user.id)
  end
end
