defmodule City.Repo.Migrations.Procedure do
  use Ecto.Migration

  def up do
    execute "CREATE OR REPLACE FUNCTION createordeletecloack(nid integer)
    RETURNS integer AS $$
    declare lol INTEGER;
      nstart DATE;
    BEGIN
      select count(*) into lol from clocks where user_id=nid;

      IF (lol = 1)
      THEN

        INSERT INTO workingtimes(\"start\", \"end\", \"user\", \"user_id\") VALUES ((SELECT inserted_at from clocks where user_id=nid LIMIT 1), now(), nid, nid);
        DELETE FROM clocks where user_id=nid;
      ELSE
        INSERT INTO clocks(user_id, inserted_at, updated_at) VALUES (nid, now(), now());
      END IF;

      return lol;
    END; $$
    LANGUAGE PLPGSQL;

    "
  end
  def down do
    execute "drop function createordeletecloack(integer);"
  end
end
