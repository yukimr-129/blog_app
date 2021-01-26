class Dtag < ApplicationRecord
    has_many :tag_drafts, dependent: :destroy
    has_many :drafts, through: :tag_drafts
end
