class ArticlesController < ApplicationController
  before_action :set_article, only: %i(show)
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

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end

  
  private

  def article_params
    params.require(:article).permit(:title, :thumbnail, :abstract, :body).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
