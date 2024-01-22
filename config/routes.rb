Rails.application.routes.draw do
  get "/balance", to: "accounts#balance"
  post "/reset", to: "transactions#reset"
  post "/event", to: "transactions#event"
end
