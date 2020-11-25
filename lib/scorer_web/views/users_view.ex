defmodule ScorerWeb.UsersView do
  use ScorerWeb, :view
  alias ScorerWeb.UsersView

  def render("index.json", %{timestamp: ts, users: users}) do
    %{timestamp: ts, users: render_many(users, UsersView, "users.json")}
  end

  def render("users.json", %{users: users}) do
    %{id: users.id,
      points: users.points}
  end
end
