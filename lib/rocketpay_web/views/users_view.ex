defmodule RocketpayWeb.UsersView do
    alias Rocketpay.{Account,User}

    def render("create.json", %{user: %User{ id: id, name: name, nickname: nickname, account: %Account{id: account_id, balance: balance}}} ) do
        account_data = %{id: account_id, balance: balance}
        user_data = %{ id: id, name: name, nickname: nickname, account: account_data } 
        
        %{ message: "User created", user: user_data }
    end
end