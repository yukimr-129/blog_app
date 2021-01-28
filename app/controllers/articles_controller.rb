class ArticlesController < ApplicationController
  before_action :set_article, only: %i(show edit update destroy)
  impressionist actions: [:show], unique: [:impressionable_id, :ip_address]

  def index
  end

  def new
    @article = Article.new
    @draft = Draft.new

    #通常保存、下書き保存判別フラグ
    $draft = false
  end

  def create
    #通常保存、下書き保存モデル切り替え
    if $draft
      model = {main: Draft,   tag: Dtag, inter: TagDraft,   column: {main: "draft_id",   tag: "dtag_id"}, redirect: drafts_path}
    else
      model = {main: Article, tag: Tag,  inter: TagArticle, column: {main: "article_id", tag: "tag_id"},  redirect: root_path}
    end

    @article = model[:main].new(article_params)
    unless @article.valid?
      flash[:notice] = @article.errors.full_messages
      render :new
      return
    end
    @article.save

    #タグ保存処理
    tag = params[:article][:tag]
    tag_array(tag).each do |t|
      #find_or_initialize_byに変更
      unless model[:tag].find_by(name: t).present?
        model[:tag].create(name: t)
      end
      @tag = model[:tag].find_by(name: t)
      model[:inter].create(model[:column][:main] => @article.id, model[:column][:tag] => @tag.id)
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

  def set_draft
    $draft = true
  end

  #検索機能
  def search
    return nil if params[:search] == ""
    @articles = Article.where("lower(title) LIKE ? OR lower(body) LIKE ?", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%")
    @articles = @articles.order(updated_at: :desc)
  end


  private

  def article_params
    params.require(:article).permit(:title, :thumbnail, :abstract, :body).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
