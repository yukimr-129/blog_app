class TagsController < ApplicationController
    def show
        @tag = Tag.find(params[:id])
        @articles = []
        @tag_articles = TagArticle.where(tag_id: params[:id])

        @tag_articles.each do |tag|
            @articles << tag.article
        end
    end
end
