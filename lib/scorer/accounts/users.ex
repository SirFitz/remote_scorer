defmodule Scorer.Accounts.Users do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Jason.Encoder, except: [:inserted_at, :__meta__]}

  schema "users" do
    field :points, :integer

    timestamps([updated_at: false, type: :utc_datetime_usec])
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:points])
    |> validate_required([:points])
    |> validate_number(:points, greater_than: -1)
    |> validate_number(:points, less_than: 101)
  end
end
