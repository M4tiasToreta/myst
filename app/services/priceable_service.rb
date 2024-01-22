class PriceableService

  def self.deposit_balance(amount, account)
    added = amount.to_i+account.balance
    update_balance(added, account)
  end

  def self.withdraw_balance(amount, account)
    subtracted = account.balance-amount.to_i
    update_balance(subtracted, account)
  end

  private 

  def self.update_balance(amount, account)
    account.update(balance: amount) # should add validations
  end
end