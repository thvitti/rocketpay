defmodule RocketpayWeb.WelcomeController do
    use RocketpayWeb, :controller

    def index(conn, _params) do
        text(conn, "rocket pay api")
    end


end