class ArticlesController < ApplicationController
  before_action :set_article, only: %i(show edit update destroy)
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

    #タグ保存処理
    tag = params[:article][:tag]
    tag_array(tag).each do |t|
      unless Tag.find_by(name: t).present?
        Tag.create(name: t)
      end
      @tag = Tag.find_by(name: t)
      TagArticle.create(article_id: @article.id, tag_id: @tag.id)
    end

    redirect_to root_url
  end

  def show
    @article_tag = @article.tags

  end

  def edit
    tags = []
    tag_articles = TagArticle.where(article_id: @article.id)
    tag_articles.each do |tag_article|
      tags << Tag.find(tag_article.tag_id).name
    end
    @tag = tags.join(" ")
  end

  def update
    unless @article.update(article_params)
      flash[:notice] = @article.errors.full_messages
      render :edit
      return
    end

    #ユーザーが削除したタグデータ削除
    TagArticle.where(article_id: @article.id).destroy_all

    #タグ再登録
    tag = params[:article][:tag]
    tag_array(tag).each do |t|
      #Tagテーブルに存在するか確認なければ新規登録
      unless Tag.find_by(name: t).present?
        Tag.create(name: t)
      end
      @tag = Tag.find_by(name: t)
      TagArticle.create(article_id: @article.id, tag_id: @tag.id)
    end

    redirect_to root_url
  end

  def destroy
    if current_user.id == @article.user_id
      if @article.destroy
        redirect_to root_url
      end
    end

  end

  #検索機能
  def search
    return nil if params[:search] == ""
    @articles = Article.where("lower(title) LIKE ? OR lower(body) LIKE ?", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%")
  end


  private

  def article_params
    params.require(:article).permit(:title, :thumbnail, :abstract, :body).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
