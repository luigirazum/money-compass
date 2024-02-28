class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.string :name, null: false, limit: 150
      t.decimal :amount, null: false, default: 0

      t.timestamps
    end

    # add author foreign key for associate a payment to a user
    add_reference :payments, :author, stored: true, null: false, index: true, foreign_key: { to_table: :users }

    # have an index for payments on payment name
    add_index :payments, :name
  end
end
