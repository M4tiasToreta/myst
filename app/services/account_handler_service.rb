class AccountHandlerService
  def self.new_receiving_account(id)
    Account.create(id: id, balance: 0) if id
  end
end