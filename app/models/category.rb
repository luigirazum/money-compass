class Category < ApplicationRecord
  # associations
  belongs_to :user
  has_many :category_payments, inverse_of: :category
  has_many :payments, lambda { |category|
    where author: category.user
  }, through: :category_payments,
     before_add: :initialize_category

  # validations
  validates_presence_of :name
  validates_length_of :name, within: 5..35
  validates_uniqueness_of :name, scope: :user_id
  validates_presence_of :icon
  validates_format_of :icon, with: %r{\Ahttps?://.*\.?(jpg|jpeg|png|gif|webp|avif|svg)?\z}i
  validates_presence_of :user_id
  validates_associated :payments

  # custom methods
  def total_amount
    payments.sum(&:amount)
  end

  private

  def initialize_category(payment)
    payment.category = self
  end
end
