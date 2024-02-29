class Category < ApplicationRecord
  # associations
  belongs_to :user

  # validations
  validates_presence_of :name
  validates_length_of :name, within: 5..35
  validates_uniqueness_of :name, scope: :user_id
  validates_presence_of :icon
  validates_format_of :icon, with: %r{\Ahttps?://.*\.?(jpg|jpeg|png|gif|webp|avif|svg)?\z}i
  validates_presence_of :user_id
end
