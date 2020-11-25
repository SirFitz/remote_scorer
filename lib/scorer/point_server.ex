defmodule Scorer.PointSever do
  use GenServer
  require Logger

  def start_link(_) do
    # Startes a GenServer with the intial state being {random_number, nil_timestamp}
    GenServer.start_link(__MODULE__, {Enum.random(1..99), nil}, [name: __MODULE__])
  end

  @impl true
  def init(state) do
    # Schedule work to be performed on start
    schedule_work()

    {:ok, state}
  end

  @impl true
  def handle_call(:get_users, _from, state) do

    {max_number, timestamp} = state

    # set the maxmium number of users to be returned to at most 2
    num_of_users = Enum.random(1..2)

    users = Scorer.Users.list(max_number, num_of_users)

    current_timestamp =
      if timestamp do
        Calendar.strftime(timestamp, "%Y-%m-%d %H:%M:%S")
      end

    reply = %{
      users: users,
      timestamp: current_timestamp
    }

    #replies with map and updates state with new timestamp
    {:reply, reply, {max_number, DateTime.utc_now()}}
  end

  @impl true
  def handle_info(:work, state) do
    {_max_number, timestamp} = state

    # Do the desired work here
    # ...
    Scorer.Users.list()
    |> Enum.each(fn(user)->
      Scorer.Users.update!(user, %{points: Enum.random(1..99)})
    end)

    # Reschedule once more
    schedule_work()

    {:noreply, {Enum.random(1..99), timestamp}}
  end

  defp schedule_work do
    # In 1 minute
    Process.send_after(self(), :work, 60 * 1000)
  end

  # Interface methods

  @doc """
  Returns a tuple with an {:ok, %{timestamp: ..., users: [...]}}
  if the call to get users is successful,
  or an {:error, map} if the call failed.
  """
  def get_users() do
    try do
      {:ok, GenServer.call(__MODULE__, :get_users)}
    catch what, value ->
      Logger.error inspect({what, value})
      {:error, %{}}
    end
  end

end
