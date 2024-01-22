class TransactionsHandlerService

  include Transactions::TransactionAccountHelper
  include Transactions::TransactionResponseHelper

  attr_accessor :type, :origin_id, :destination_id, :amount

  def initialize(type, origin_id=[], destination_id=[], amount)
    @type = type[1]
    @origin_id = origin_id[1]
    @destination_id = destination_id[1]
    @amount = amount[1]
  end

  def call
    send "handle_#{type}"
  end

  private

  def handle_transfer
    if origin_account.nil?
      nil
    else
      PriceableService.withdraw_balance(amount, origin_account)
      PriceableService.deposit_balance(amount, destination_account)
      transfer_response
    end
  end

  def handle_withdraw
    if origin_account.nil?
      nil
    else
      PriceableService.withdraw_balance(amount, origin_account)
      origin_response
    end
  end

  def handle_deposit
    PriceableService.deposit_balance(amount, destination_account)
    destination_response
  end
end
