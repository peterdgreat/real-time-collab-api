class Document < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :tasks
  validates :title, presence: true
  validates :content, presence: true
end
