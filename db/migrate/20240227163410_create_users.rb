class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false

      t.timestamps
    end
    # make sure names don't repeat
    add_index :users, :name, unique: true, name: 'unique_user_names'
  end
end
