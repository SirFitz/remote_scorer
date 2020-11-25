defmodule ScorerWeb.Router do
  use ScorerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ScorerWeb do
    pipe_through :api

    get "/", UsersController, :index
  end
end
