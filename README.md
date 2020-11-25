# Scorer

This is `Scorer`, it's an API that returns a list of up to 2 users with points lower than a randomly selected amount.

The points of the users are refreshed every minute and the timestamp received in the response is the timestamp of the last request to the API.

### Requirements
To start your application you'll need to have:
  * Elixir 1.5 or greater installed.
  * Postgres instance with the listening port set to 5432.
  * The user `scorer_user` with password `UltraPass#23` and permission to create and manage database.
  * You may also choose to swap out the database access credentials in `'/config/dev.exs'`.

### Startup
To start the Phoenix API server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Ensure PORT `4000` is free on your machine or update the PORT number in `'/config/dev.exs'` to your prefered PORT.
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser (change 4000 to the appropriate PORT if you updated your config file with a different port).

You can expect to receive a response as below in your first request after the server is started:
```json
{
 "timestamp":null,
 "users": [
    {"id":78,"points":12}
 ]
}
```
You can expect to receive a response as below in following requests:
```json
{
 "timestamp":"2020-11-25 04:54:37",
 "users": [
    {"id":78,"points":12},
    {"id":53,"points":97}
 ]
}
```

This application is not set up to run in production.
