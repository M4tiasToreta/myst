class AccountsController < ApplicationController
  before_action :set_account, only: %i[ balance ]

  def balance
    if @account.present?
      render plain: @account.balance.to_s
    else
      render plain: 0.to_s, status: :not_found
    end
  end

  private
  def set_account
    @account = Account.find(params[:account_id])
  rescue ActiveRecord::RecordNotFound
    @account = nil
  end
end
