defmodule RocketpayWeb.AccountsView do
  
  def render("update.json", %{account: %Rocketpay.Account{id: account_id, balance: balance}}) do
    %{
      message: "Ballance changed succefully",
      account: %{id: account_id, balance: balance}
    }
  end

  def render("transaction.json", %{transaction: %{to_account: to_account, from_account: from_account} }) do
    %{
      message: "Transaction done succefully",
      transaction: %{ 
        from_account: %{id: from_account.id, balance: from_account.balance},
        to_account: %{id: to_account.id, balance: to_account.balance}
      }
    }
  end
end