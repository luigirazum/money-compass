class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false, limit: 35
      t.string :icon, null: false

      t.timestamps
    end
    add_index :categories, :name, unique: true, name: 'unique_category_names'
  end
end
