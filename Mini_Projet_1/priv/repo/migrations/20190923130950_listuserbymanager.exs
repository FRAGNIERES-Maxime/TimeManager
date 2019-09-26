defmodule City.Repo.Migrations.Listuserbymanager do
  use Ecto.Migration

  def up do
    execute "
    CREATE OR REPLACE FUNCTION LIST_USER_MANAGER(mId integer)
    RETURNS TABLE (id BIGINT, email VARCHAR, status INT, username VARCHAR) as $$
    BEGIN
      return query select u.id, u.email, u.status, u.username from associations as a
      LEFT JOIN users as u On a.id_manager=u.id
      where a.id_manager=mId;
    END; $$

    LANGUAGE 'plpgsql';"
  end
  def down do
    execute "drop function list_user_manager;"
  end
end
