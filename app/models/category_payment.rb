class CategoryPayment < ApplicationRecord
  # associations
  belongs_to :category
  belongs_to :payment

  # validations
  validates_presence_of :category_id
  validates_presence_of :payment_id
  validates_uniqueness_of :payment_id, scope: :category_id
end
