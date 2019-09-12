defmodule City.Repo.Migrations.CreateClocks do
  use Ecto.Migration

  def change do
    create table(:clocks) do
      add :user_id, :integer

      timestamps()
    end

  end
end
