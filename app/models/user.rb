class User < ApplicationRecord
  # associations
  has_many :categories, inverse_of: :user
  has_many :payments, inverse_of: :author, foreign_key: :author_id

  # validations
  validates_presence_of :name
  validates_uniqueness_of :name
end
