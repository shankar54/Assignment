class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|

      t.references :sender, index: true
      t.references :receiver, index: true
      t.integer :amount, default: 0, null: false
      t.timestamps null: false
    end
  end
end
