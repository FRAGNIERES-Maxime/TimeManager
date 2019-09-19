defmodule City.Repo.Migrations.CreateWorkingtimes do
  use Ecto.Migration

  def change do
    create table(:workingtimes) do
      add :start, :naive_datetime
      add :end, :naive_datetime
      add :user, references(:users)
      add :user_id, :integer
    end

    create index(:workingtimes, [:user])
  end
end
