defmodule City.Repo.Migrations.CreateAssociations do
  use Ecto.Migration

  def change do
    create table(:associations) do
      add :id_manager, :integer
      add :id_user, :integer

      timestamps()
    end

  end
end
