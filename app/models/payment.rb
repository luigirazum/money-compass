class Payment < ApplicationRecord
  # associations
  belongs_to :author, foreign_key: :author_id, class_name: 'User'
  has_one :category_payment, inverse_of: :payment
  has_one :category, through: :category_payment

  # validations
  validates_presence_of :name
  validates_length_of :name, within: 5..150
  validates_presence_of :amount
  validates_numericality_of :amount, greater_than: 0
  validates_presence_of :author_id
  validates_presence_of :category
  validates_inclusion_of :category, within: :permited_categories

  private

  def permited_categories
    author.categories
  end
end
