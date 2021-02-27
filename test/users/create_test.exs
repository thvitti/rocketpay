defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.Users.Create
  alias Rocketpay.{Repo,User}
  
  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{ 
        name: "Homer Simpson", 
        nickname: "homer", 
        password: "12345", 
        email: "homer@thesimpsons.com", 
        age: 45 }

      {:ok, %User{id: user_id}} = Create.call(params)
      
      user = Repo.get(User, user_id)

      assert %User{name: "Homer Simpson", age: 45, id: ^user_id} = user
    end

    test "when there are invalid params, returns an user" do
      params = %{ 
        name: "Bart Simpson", 
        nickname: "bart", 
        email: "bart@thesimpsons.com", 
        age: 15 }

      {:error, changeset} = Create.call(params)
      
      expected_response = %{ age: ["must be greater than or equal to 18"], 
                             password: ["can't be blank"]
                           }

      assert errors_on(changeset) == expected_response
      
    end


  end

end