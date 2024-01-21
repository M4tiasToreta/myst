require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  describe "GET balance" do
    before { Account.create(balance: 20) }

    it "Get balance for non-existing account" do
      get "/balance?account_id=1234"

      expect(response.status).to eq 404
      expect(body).to eq 0
    end

    it "Get balance for existing account" do
      # binding.break
      get "/balance?account_id=100"

      expect(response.status).to be_ok
      expect(body).to eq "20"
    end
  end
end
