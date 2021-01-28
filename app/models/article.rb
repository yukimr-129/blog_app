class Article < ApplicationRecord

    has_many :tag_articles, dependent: :destroy
    has_many :tags, through: :tag_articles
    belongs_to :user

    mount_uploader :thumbnail, ImageUploader
    is_impressionable counter_cache: true

    has_many :likes, dependent: :destroy
end
