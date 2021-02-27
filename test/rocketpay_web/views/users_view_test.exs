defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase, async: true

  alias Rocketpay.{Account,User}
  alias RocketpayWeb.UsersView

  test "renders create.json" do
    params = %{
      name: "Marge Simpson",
      nickname: "marge",
      age: 38,
      password: "saxphone",
      email: "marge@thesimpsons.com"
    }
    {:ok, %User{ id: user_id, account: %Account{id: account_id} } = user} = Rocketpay.create_user(params)

    response = Phoenix.View.render(UsersView, "create.json", user: user)
    expected_response = %{ 
                          message: "User created", 
                          user: %{ 
                            account: %{
                              balance: Decimal.new("0.00"), 
                              id: account_id
                            }, 
                            id: user_id, 
                            name: "Marge Simpson", 
                            nickname: "marge"
                          }
                        }
    assert expected_response == response
  end
end