class CreateCategoryPayments < ActiveRecord::Migration[7.1]
  def change
    create_table :category_payments do |t|

      t.timestamps
    end

    # Add references
    add_reference :category_payments, :category, null: false, index: { name: 'category_with_payments' }, foreign_key: true
    add_reference :category_payments, :payment, null: false, index: { name: 'payment_with_category' }, foreign_key: true

    # no duplicate payments for a given category
    add_index :category_payments, [:category_id, :payment_id], unique: true, name: 'unique_payments_by_category'
  end
end
