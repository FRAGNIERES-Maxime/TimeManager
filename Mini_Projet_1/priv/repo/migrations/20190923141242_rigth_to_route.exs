defmodule City.Repo.Migrations.RigthToRoute do
  use Ecto.Migration

  def up do
    "CREATE OR REPLACE FUNCTION rigth_to_route(
      mid integer,
      uid integer)
    RETURNS TABLE (id integer, email VARCHAR, status integer, username VARCHAR) AS
  $BODY$
  DECLARE
    Mstatus integer;
  BEGIN
    Mstatus = (select us.status from users as us where us.id=mId);

    IF (Mstatus = 2) THEN
      return query (select u.id, u.email, u.status, u.username from users as u where u.id=uId);
    ELSE
      return query (select u.id, u.email, u.status, u.username from users as u
      left join associations as a on a.id_user=u.id
      where u.id=uId and a.id=mId);
    end if;
  END;$BODY$
    LANGUAGE plpgsql;"

  end
  def down do
    "drop function rigth_to_route"
  end
end
