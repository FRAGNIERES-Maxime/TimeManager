defmodule City.Cloakeur.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clocks" do
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:user_id])
    |> validate_required([:user_id])
  end
end
