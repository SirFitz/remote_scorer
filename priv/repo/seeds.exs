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
Enum.each(1..100, fn(_num)->
    Scorer.Accounts.create_users(%{points: 0})
end)
