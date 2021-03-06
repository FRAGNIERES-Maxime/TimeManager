defmodule Bcrypt.Stats do
  @moduledoc """
  Module to provide statistics for the Bcrypt password hashing function.

  ## Configuring Bcrypt

  There is one configuration option for Bcrypt - log_rounds.
  Increasing this value will increase the complexity, and time
  taken, of the Bcrypt function.

  Increasing the time that a password hash function takes makes it more
  difficult for an attacker to find the correct password. However, the
  amount of time a valid user has to wait also needs to be taken into
  consideration when setting the number of log rounds.

  The correct number of log rounds depends on circumstances specific to your
  use case, such as what level of security you want, how often the user
  has to log in, and the hardware you are using. However, for password
  hashing, we do not recommend setting the number of log rounds to anything
  less than 12.
  """

  @doc """
  Hash a password with Bcrypt and print out a report.

  This function hashes a password, and salt, with Bcrypt.Base.hash_password/2
  and prints out statistics which can help you choose how many to configure
  Bcrypt.

  ## Options

  There are three options:

    * log_rounds - the number of log rounds
      * the default is 12
    * password - the password used
      * the default is "password"
    * salt - the salt used
      * the default is the output of Bcrypt.gen_salt
  """
  def report(opts \\ []) do
    password = Keyword.get(opts, :password, "password")
    log_rounds = Keyword.get(opts, :log_rounds, 12)
    salt = Keyword.get(opts, :salt, Bcrypt.gen_salt(log_rounds))
    {exec_time, encoded} = :timer.tc(Bcrypt.Base, :hash_password, [password, salt])
    Bcrypt.verify_pass(password, encoded)
    |> format_result(encoded, exec_time)
  end

  defp format_result(check, encoded, exec_time) do
    log_rounds = String.slice(encoded, 4..5)
    IO.puts """
    Hash:\t\t#{encoded}
    Log rounds:\t#{log_rounds}
    Time taken:\t#{format_time(exec_time)} seconds
    Verification #{if check, do: "OK", else: "FAILED"}
    """
  end

  defp format_time(time) do
    Float.round(time / 1_000_000, 2)
  end
end
