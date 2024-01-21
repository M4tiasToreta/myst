class AccountsController < ApplicationController
  before_action :set_account, only: %i[ balance ]

  # GET /accounts
  def balance
    render plain: @account.balance
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:account_id])
    end
end
