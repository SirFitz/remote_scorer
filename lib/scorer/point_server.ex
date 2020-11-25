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

    current_timestamp = format_date_time(timestamp)

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

  # formats date time to required format if it is not nil
  # eg: "2020-11-25 01:24:22"
  defp format_date_time(nil), do: nil
  defp format_date_time(dt) do
    date = "#{dt.year}-#{zero_pad(dt.month)}-#{zero_pad(dt.day)}"
    time = "#{zero_pad(dt.hour)}:#{zero_pad(dt.minute)}:#{zero_pad(dt.second)}"
    "#{date} #{time}"
  end

  # pads numbers with zero if it is less than 10
  defp zero_pad(nil), do: nil
  defp zero_pad(num) when num < 10, do: "0#{num}"
  defp zero_pad(num), do: num


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
