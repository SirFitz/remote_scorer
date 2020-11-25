defmodule Scorer.Servers.PointSever do
  use GenServer
  require Logger

  def start_link(_) do
    # Startes a GenServer with the intial state being {random_number, nil_timestamp}
    GenServer.start_link(__MODULE__, {Enum.random(0..100), nil}, [name: __MODULE__])
  end

  @impl true
  def init(state) do
    # Runs a task to initiate users points and ensure there is no blocking of the GenServer.
    Task.start(fn -> Scorer.Accounts.update_users_points() end)

    # Schedule work to be performed on start
    schedule_work()

    {:ok, state}
  end

  @impl true
  def handle_call(:get_users, _from, state) do

    {max_number, timestamp} = state

    # sets the maxmium number of users to be returned to at most 2
    # and the minimum points users should have to be the max_number of the state
    user_filters = %{"min_points" => max_number, "limit" => Enum.random(1..2)}

    reply = %{
      users: Scorer.Accounts.list_users(user_filters),
      timestamp: Scorer.Helpers.Utils.format_date_time(timestamp)
    }

    # replies with map and updates state with new timestamp
    {:reply, reply, {max_number, DateTime.utc_now()}}
  end

  @impl true
  def handle_info(:work, state) do
    {_max_number, timestamp} = state

    # Runs a task to ensure there is no blocking of the GenServer when a request is made.
    Task.start(fn -> Scorer.Accounts.update_users_points() end)

    # Reschedule once more
    schedule_work()

    {:noreply, {Enum.random(0..100), timestamp}}
  end

  defp schedule_work, do: Process.send_after(self(), :work, 60 * 1000)


  # Interface methods

  @doc """
  Returns a map with a timestamp and list of users

  ## Examples

      iex> get_users()
      %{timestamp: ..., users: [...]}

  """
  def get_users, do: GenServer.call(__MODULE__, :get_users)

end
