class Payment < ApplicationRecord
  # validations
  validates_presence_of :name
  validates_length_of :name, within: 5..150
  validates_presence_of :amount
  validates_numericality_of :amount, greater_than: 0
end
