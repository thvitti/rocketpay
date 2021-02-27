defmodule RocketpayWeb.AccountsControllerTest do
  use RocketpayWeb.ConnCase, async: true

  alias Rocketpay.{Account,User}

  describe "deposit/2" do
    setup %{conn: conn} do
      params = %{
        name: "Marge Simpson",
        nickname: "marge",
        age: 38,
        password: "saxphone",
        email: "marge@thesimpsons.com"
      }
      {:ok, %User{ account: %Account{id: account_id} }} = Rocketpay.create_user(params)
      
      conn = put_req_header(conn, "authorization", "Basic YmFuYW5hOm5hbmljYTEyMw==")

      {:ok, conn: conn, account_id: account_id}
    end
    
    test "when got valid params, make the deposit", %{conn: conn, account_id: account_id} do
        params = %{value: "3.0"}

        response = conn
          |> post( Routes.accounts_path(conn, :deposit, account_id, params) )
          |> json_response(:ok)

        assert %{"account" => %{"balance" => "3.00", "id" => ^account_id}, "message" => "Ballance changed succefully"} = response
    end

    test "when got invalid params, return an error", %{conn: conn, account_id: account_id} do
      params = %{value: "invalid_amount"}

      response = conn
      |> post( Routes.accounts_path(conn, :deposit, account_id, params) )
      |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid operation value!"}
      assert expected_response == response
    end
  end

  describe "withdraw/2" do
    setup %{conn: conn} do
      params = %{
        name: "Marge Simpson",
        nickname: "marge",
        age: 38,
        password: "saxphone",
        email: "marge@thesimpsons.com"
      }

      {:ok, %User{ account: %Account{id: account_id}} } = Rocketpay.create_user(params)
      conn = put_req_header(conn, "authorization", "Basic YmFuYW5hOm5hbmljYTEyMw==")
      {:ok, conn: conn, account_id: account_id}
    end

    test "when got valid params and an account with balance, make the withdraw", %{conn: conn, account_id: account_id} do
      params_deposit = %{"id" => account_id, "value" => "4.00"}
      params_withdraw = %{value: "2.00"}
      expected_balance = "2.00"

      Rocketpay.deposit(params_deposit)

      response = 
        conn
        |> post( Routes.accounts_path(conn, :withdraw, account_id, params_withdraw) ) 
        |> json_response(:ok)

      expected_response = %{"account" => %{"balance" => expected_balance, "id" => account_id}, "message" => "Ballance changed succefully"}
      assert expected_response == response
    end

    test "when got invalid params, return an error", %{conn: conn, account_id: account_id} do
      params = %{value: "invalid_value"}

      response = 
        conn
        |> post( Routes.accounts_path(conn, :withdraw, account_id, params) )
        |> json_response(400)

      expected_response = %{"message" => "Invalid operation value!"}
      assert expected_response == response
    end

  end
end