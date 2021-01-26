class Draft < ApplicationRecord
    has_many :tag_drafts, dependent: :destroy
    has_many :dtags, through: :tag_drafts
end
