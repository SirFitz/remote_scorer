defmodule ScorerWeb.UsersController do
  use ScorerWeb, :controller

  action_fallback ScorerWeb.FallbackController

  def index(conn, _params) do
    data = Scorer.Servers.PointSever.get_users()
    render(conn, "index.json", data)
  end

end
