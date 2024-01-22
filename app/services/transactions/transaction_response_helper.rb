module Transactions::TransactionResponseHelper
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