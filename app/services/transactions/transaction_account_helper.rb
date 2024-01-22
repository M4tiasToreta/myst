module Transactions::TransactionAccountHelper
  def destination_account
    return @destination_account if @destination_account
    @destination_account = Account.find(destination_id)
  rescue ActiveRecord::RecordNotFound
    AccountHandlerService.new_receiving_account(destination_id)
  end

  def origin_account
    return @origin_account if @origin_account
    @origin_account = Account.find(origin_id)
  rescue ActiveRecord::RecordNotFound
    nil
  end
end