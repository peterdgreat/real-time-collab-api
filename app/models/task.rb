class Task < ApplicationRecord
  belongs_to :user
  belongs_to :document
  validates :title, presence: true
  validates :status, presence: true
end
