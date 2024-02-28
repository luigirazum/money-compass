class Category < ApplicationRecord
  # validations
  validates_presence_of :name
  validates_length_of :name, within: 5..35
  validates_uniqueness_of :name
  validates_presence_of :icon
  validates_format_of :icon, with: %r{\Ahttps?://.*\.?(jpg|jpeg|png|gif|webp|avif|svg)?\z}i
end
