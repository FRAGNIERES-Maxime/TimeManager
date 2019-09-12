defmodule City.CloakeurTest do
  use City.DataCase

  alias City.Cloakeur

  describe "clocks" do
    alias City.Cloakeur.Clock

    @valid_attrs %{user_id: 42}
    @update_attrs %{user_id: 43}
    @invalid_attrs %{user_id: nil}

    def clock_fixture(attrs \\ %{}) do
      {:ok, clock} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cloakeur.create_clock()

      clock
    end

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert Cloakeur.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert Cloakeur.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      assert {:ok, %Clock{} = clock} = Cloakeur.create_clock(@valid_attrs)
      assert clock.user_id == 42
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cloakeur.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{} = clock} = Cloakeur.update_clock(clock, @update_attrs)
      assert clock.user_id == 43
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = Cloakeur.update_clock(clock, @invalid_attrs)
      assert clock == Cloakeur.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = Cloakeur.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> Cloakeur.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = Cloakeur.change_clock(clock)
    end
  end
end
