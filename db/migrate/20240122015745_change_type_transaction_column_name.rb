class ChangeTypeTransactionColumnName < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :transactions, :accounts, column: :origin
    add_foreign_key :transactions, :accounts, column: :destination
    rename_column :transactions, :type, :type_transaction
  end
end
