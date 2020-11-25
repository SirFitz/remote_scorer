defmodule Scorer.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :points, :integer

      timestamps([updated_at: false, type: :utc_datetime_usec])
    end

    create constraint(
          :users,
          :user_points_must_be_between_0_and_100,
          check: "points > 0 and points < 100"
    )
  end
end
