class User < ApplicationRecord
  # Include devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  # associations
  has_many :categories, inverse_of: :user
  has_many :payments, inverse_of: :author, foreign_key: :author_id

  # validations
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_associated :categories
  validates_associated :payments
end
