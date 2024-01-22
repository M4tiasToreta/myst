class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.string :type
      t.integer :amount
      t.integer :destination
      t.integer :origin

      t.timestamps
    end
  end
end
