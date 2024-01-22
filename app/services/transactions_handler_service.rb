class TransactionsHandlerService

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

  def destination_response
    {:destination => {id: destination_id, balance: destination_account.balance}}
  end

  def origin_response
    {:origin => {id: origin_id, balance: origin_account.balance}}
  end

  def transfer_response
    origin_response.merge(destination: destination_response[:destination])
  end
end
