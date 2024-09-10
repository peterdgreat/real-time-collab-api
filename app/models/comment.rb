class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :document
  validates :content, presence: true
end
