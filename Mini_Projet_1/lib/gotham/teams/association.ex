defmodule City.Teams.Association do
  use Ecto.Schema
  import Ecto.Changeset

  schema "associations" do
    field :id_manager, :integer
    field :id_user, :integer

    timestamps()
  end

  @doc false
  def changeset(association, attrs) do
    association
    |> cast(attrs, [:id_manager, :id_user])
    |> validate_required([:id_manager, :id_user])
  end
end
