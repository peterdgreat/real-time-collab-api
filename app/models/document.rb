class Document < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :tasks
end
