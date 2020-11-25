defmodule Scorer.Helpers.Utils do
  @moduledoc """
  The Helper Utility Functions.
  """

  @doc """
  Returns a formatted date time, this function is needed to support older versions
  of Elixir without DateTime much formatting.

  ## Examples

      iex> format_date_time(DateTime.utc_now)
      "2020-11-25 17:32:19"

  """
  def format_date_time(nil), do: nil
  def format_date_time(dt) do
    date = "#{dt.year}-#{zero_pad(dt.month)}-#{zero_pad(dt.day)}"
    time = "#{zero_pad(dt.hour)}:#{zero_pad(dt.minute)}:#{zero_pad(dt.second)}"
    "#{date} #{time}"
  end

  @doc """
  Pads single numbers less than 10 with zero.

  ## Examples

      iex> zero_pad(4)
      "04"

  """
  def zero_pad(nil), do: nil
  def zero_pad(num) when num < 10, do: "0#{num}"
  def zero_pad(num), do: num


end
