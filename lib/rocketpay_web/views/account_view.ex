defmodule RocketpayWeb.AccountsView do
  
  def render("update.json", %{account: %Rocketpay.Account{id: account_id, balance: balance}}) do
    %{
      message: "Ballance changed succefully",
      account: %{id: account_id, balance: balance}
    }
  end
end