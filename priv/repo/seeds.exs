# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Scorer.Repo.insert!(%Scorer.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
users = 1..100
|> Enum.map(fn(_num)->
    %{
      points: 0,
      inserted_at: DateTime.utc_now(),
    }
end)

case Scorer.Repo.insert_all(Scorer.Users, users) do
  {100, nil} -> {:ok, "Added Users"}
  error ->
    raise """
      Failed to add all users to database.
      #{inspect error}
      """
end
