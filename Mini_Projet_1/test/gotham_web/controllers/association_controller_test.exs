defmodule CityWeb.AssociationControllerTest do
  use CityWeb.ConnCase

  alias City.Teams
  alias City.Teams.Association

  @create_attrs %{
    id_mangager: 42,
    id_user: 42
  }
  @update_attrs %{
    id_mangager: 43,
    id_user: 43
  }
  @invalid_attrs %{id_mangager: nil, id_user: nil}

  def fixture(:association) do
    {:ok, association} = Teams.create_association(@create_attrs)
    association
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all associations", %{conn: conn} do
      conn = get(conn, Routes.association_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create association" do
    test "renders association when data is valid", %{conn: conn} do
      conn = post(conn, Routes.association_path(conn, :create), association: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.association_path(conn, :show, id))

      assert %{
               "id" => id,
               "id_mangager" => 42,
               "id_user" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.association_path(conn, :create), association: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update association" do
    setup [:create_association]

    test "renders association when data is valid", %{conn: conn, association: %Association{id: id} = association} do
      conn = put(conn, Routes.association_path(conn, :update, association), association: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.association_path(conn, :show, id))

      assert %{
               "id" => id,
               "id_mangager" => 43,
               "id_user" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, association: association} do
      conn = put(conn, Routes.association_path(conn, :update, association), association: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete association" do
    setup [:create_association]

    test "deletes chosen association", %{conn: conn, association: association} do
      conn = delete(conn, Routes.association_path(conn, :delete, association))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.association_path(conn, :show, association))
      end
    end
  end

  defp create_association(_) do
    association = fixture(:association)
    {:ok, association: association}
  end
end
