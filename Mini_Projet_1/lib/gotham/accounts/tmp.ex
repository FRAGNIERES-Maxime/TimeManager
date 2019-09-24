defmodule City.Accounts.Tmp do
  use Ecto.Schema
  import Ecto.Changeset
  alias City.Accounts.Tmp

  schema "tmps" do
    field :rigth_to_route, :integer
  end

  def changeset(tmp, attrs) do
    tmp
    |> cast(attrs, [:rigth_to_route])
  end

end
