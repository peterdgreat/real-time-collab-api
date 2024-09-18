class Document < ApplicationRecord
  belongs_to :user # Ensure this association is present
  has_many :comments
  has_many :tasks
  has_many :document_users
  has_many :users, through: :document_users
  validates :title, presence: true
  validates :content, presence: true
end
