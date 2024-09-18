class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self


  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  include Devise::JWT::RevocationStrategies::JTIMatcher

  has_many :comments
  has_many :tasks

  has_many :document_users
  has_many :documents, through: :document_users
end
