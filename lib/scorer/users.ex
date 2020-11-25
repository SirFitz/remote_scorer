defmodule Scorer.Users do
  use Ecto.Schema
  import Ecto.{Changeset, Query}
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
    |> validate_number(:points, greater_than: 0)
    |> validate_number(:points, less_than: 100)
  end

  @doc """
  Accepts a map containing an integer field called points and creates a new user.
  If the insert fails, it throws an error.
  """
  def create!(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Scorer.Repo.insert!()
  end

  @doc """
  Accepts a Scorer.Users struct and a map containing an integer field called points and updates the user.
  If the update fails, it throws an error.
  """
  def update!(user, attrs) do
    user
    |> changeset(attrs)
    |> Scorer.Repo.update!()
  end

  @doc """
  Returns a list of users from the database
  """
  def list() do
    Scorer.Users
    |> Scorer.Repo.all()
  end

  @doc """
  Returns a list of users with points greater than the max_points provided.
  """
  def list(max_points, num_of_users \\ 2) when is_integer(max_points) and is_integer(num_of_users) do
    Scorer.Users
    |> where([u], u.points > ^max_points)
    |> limit(^num_of_users)
    |> Scorer.Repo.all()
  end
end
