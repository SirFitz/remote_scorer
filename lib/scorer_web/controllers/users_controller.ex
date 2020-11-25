defmodule ScorerWeb.UserController do
  use ScorerWeb, :controller
  require Logger

  def index(conn, _params) do
    case Scorer.PointSever.get_users() do
      {:ok, response} ->
        conn
        |> json(response)
      {:error, data} ->
        conn
        |> put_status(500)
        |> json(data)
    end
  end
end
