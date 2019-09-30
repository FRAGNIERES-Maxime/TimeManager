defmodule City.Repo.Migrations.Listuserbymanager do
  use Ecto.Migration

  def up do
    execute "
    CREATE OR REPLACE FUNCTION LIST_USER_MANAGER(mId integer)
    RETURNS TABLE (id BIGINT, email VARCHAR, status INT, username VARCHAR) as $$
    BEGIN
      return query select u.id, u.email, u.status, u.username from users  as u
      LEFT JOIN associationsas a On a.id_user=u.id
      where a.id_manager=mId;
    END; $$

    LANGUAGE 'plpgsql';"
  end
  def down doers
    execute "drop function list_user_manager;"
  end
end
