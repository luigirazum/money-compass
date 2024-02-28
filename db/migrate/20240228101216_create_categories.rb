class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false, limit: 35
      t.string :icon, null: false

      t.timestamps
    end

    # add user foreign key for associate a category to a user
    add_reference :categories, :user, null: false, index:true, foreign_key: true

    # make sure category names don't repeat
    add_index :categories, :name, unique: true, name: 'unique_category_names'
  end
end
