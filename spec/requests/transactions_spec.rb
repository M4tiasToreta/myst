require 'rails_helper'
require 'json'

RSpec.describe "TransactionsController", type: :request do
  describe "GET /reset" do
    context "reset" do
      it "exepects ok" do
        post "/reset"

        expect(response).to be_ok
      end
    end
  end

  describe "POST /event" do
    it "creates account with initial balance" do
      post "/event", params: {"type": "deposit", "destination": "100", "amount": 10}, as: :json

      expect(response.status).to eq 201
      expect(JSON.parse(body).deep_symbolize_keys).to eq({:destination=>{:id=>"100", :balance=>10}})
    end

    it "deposit into existing account" do
      post "/event", params: {"type": "deposit", "destination": "100", "amount": 10}, as: :json

      expect(response.status).to eq 201
      expect(JSON.parse(body).deep_symbolize_keys).to eq({:destination=>{:id=>"100", :balance=>20}})
    end

    it "Withdraw from non-existing account" do
      post "/event", params: {"type": "withdraw", "origin": "200", "amount": 10}, as: :json

      expect(response.status).to eq 404
      expect(JSON.parse(body)).to eq 0
    end

    it "Withdraw from existing account" do
      post "/event", params: {"type": "withdraw", "origin": "100", "amount": 5}, as: :json

      expect(response.status).to eq 201
      expect(JSON.parse(body).deep_symbolize_keys).to eq({:origin=>{:id=>"100", :balance=>15}})
    end

    it "Transfer from existing account" do
      post "/event", params: {"type": "transfer", "origin": "100", "amount": 15, "destination": "300"}, as: :json

      expect(response.status).to eq 201
      expect(JSON.parse(body).deep_symbolize_keys).to eq({:origin=>{:id=>"100", :balance=>0}, :destination=>{:id=>"300", :balance=>15}})
    end

    it "Transfer from non-existing account" do
      post "/event", params: {"type": "transfer", "origin": "200", "amount": 15, "destination": "300"}, as: :json

      expect(response.status).to eq 404
      expect(JSON.parse(body)).to eq 0
    end
  end
end
