defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase, async: true

  import Phoenix.View

  alias Rocketpay.{Account, User}
  alias RocketpayWeb.UsersView

  test "reders create.json" do
    params = %{
      name: "Guilherme P Lima",
      password: "123456",
      nickname: "Guipedrosa",
      email: "teste@guipedrosa.com",
      age: 39
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = Rocketpay.create_user(params)

    response = render(UsersView, "create.json", user: user)

    expected_response = %{
      message: "User created",
      user: %{
        account: %{
          balance: Decimal.new("0.00"),
          id: account_id
        },
        id: user_id,
        name: "Guilherme P Lima",
        nickname: "Guipedrosa"
      }
    }

    assert expected_response == response

  end
end
