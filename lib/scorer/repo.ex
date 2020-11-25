defmodule Scorer.Repo do
  use Ecto.Repo,
    otp_app: :scorer,
    adapter: Ecto.Adapters.Postgres
end
