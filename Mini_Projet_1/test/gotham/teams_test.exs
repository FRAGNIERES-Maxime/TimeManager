defmodule City.TeamsTest do
  use City.DataCase

  alias City.Teams

  describe "associations" do
    alias City.Teams.Association

    @valid_attrs %{id_mangager: 42, id_user: 42}
    @update_attrs %{id_mangager: 43, id_user: 43}
    @invalid_attrs %{id_mangager: nil, id_user: nil}

    def association_fixture(attrs \\ %{}) do
      {:ok, association} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Teams.create_association()

      association
    end

    test "list_associations/0 returns all associations" do
      association = association_fixture()
      assert Teams.list_associations() == [association]
    end

    test "get_association!/1 returns the association with given id" do
      association = association_fixture()
      assert Teams.get_association!(association.id) == association
    end

    test "create_association/1 with valid data creates a association" do
      assert {:ok, %Association{} = association} = Teams.create_association(@valid_attrs)
      assert association.id_mangager == 42
      assert association.id_user == 42
    end

    test "create_association/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Teams.create_association(@invalid_attrs)
    end

    test "update_association/2 with valid data updates the association" do
      association = association_fixture()
      assert {:ok, %Association{} = association} = Teams.update_association(association, @update_attrs)
      assert association.id_mangager == 43
      assert association.id_user == 43
    end

    test "update_association/2 with invalid data returns error changeset" do
      association = association_fixture()
      assert {:error, %Ecto.Changeset{}} = Teams.update_association(association, @invalid_attrs)
      assert association == Teams.get_association!(association.id)
    end

    test "delete_association/1 deletes the association" do
      association = association_fixture()
      assert {:ok, %Association{}} = Teams.delete_association(association)
      assert_raise Ecto.NoResultsError, fn -> Teams.get_association!(association.id) end
    end

    test "change_association/1 returns a association changeset" do
      association = association_fixture()
      assert %Ecto.Changeset{} = Teams.change_association(association)
    end
  end
end
