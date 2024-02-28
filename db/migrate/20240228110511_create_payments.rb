class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.string :name, null: false, limit: 150
      t.decimal :amount, null: false, default: 0

      t.timestamps
    end
    add_index :payments, :name
  end
end
