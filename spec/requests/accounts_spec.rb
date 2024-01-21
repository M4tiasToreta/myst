require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  describe "GET balance" do
    before { Account.create(id: 100, balance: 20) }

    it "for non-existing account" do
      get "/balance?account_id=1234"

      expect(response.status).to eq 404
      expect(response.body.to_i).to eq 0
    end

    it "for existing account" do
      get "/balance?account_id=100"
    
      expect(response).to be_ok
      expect(response.body).to eq "20"
    end
  end
end
