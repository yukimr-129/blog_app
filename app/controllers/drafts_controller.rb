class DraftsController < ApplicationController
    before_action :set_draft, only: %i(show edit update destroy)
    
    def index

    end

    def show
        @draft_dtag = Draft.dtags
    end

    def edit
        $draft = false
        tags = []
        TagDraft.where(draft_id: @draft.id).each do |t|
            tags << Dtag.find(t.dtag_id).name
        end
        @tags = tags.join(" ")
    end

    def update
        TagDraft.where(draft_id: @draft.id).destroy_all

        if $draft
            model = {tag: Dtag, inter: TagDraft,   column: {main: "draft_id",   tag: "dtag_id"}, redirect: drafts_path}
            if @draft.valid?
              @draft.update(draft_params)
            else
              render :edit
            end
        else
            model = {tag: Tag,  inter: TagArticle, column: {main: "article_id", tag: "tag_id"},  redirect: root_path}
            @draft = Article.new(draft_params)
            if @draft.valid?
              @draft.save
            else
              render :edit
            end
        end

        tag = tag_array(params[:draft][:tag])
        tag.each do |p|
            #find_or_initialize_byに変更
            unless model[:tag].find_by(name: p).present?
                model[:tag].create(name: p)
            end
            @dtag = model[:tag].find_by(name: p)
            model[:inter].create(model[:column][:main] => @draft.id, model[:column][:tag] => @dtag.id)
        end

        unless $draft
            Draft.find(params[:id]).destroy
        end

        redirect_to root_path
    end

    def destroy
        if @draft.user_id == current_user.id
            if @draft.destroy
                redirect_to root_url
            end
        end
    end

    private

    def draft_params
        params.require(:draft).permit(:title, :thumbnail, :abstract, :body).nerge(user_id: current_user.id)
    end

    def set_draft
        @draft = Draft.find(params[:id])
    end
end
