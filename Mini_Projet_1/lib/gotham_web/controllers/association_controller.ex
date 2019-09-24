defmodule CityWeb.AssociationController do
  use CityWeb, :controller

  alias City.Teams
  alias City.Teams.Association

  action_fallback CityWeb.FallbackController

  def index(conn, _params) do
    associations = Teams.list_associations()
    render(conn, "index.json", associations: associations)
  end

  def create(conn, %{"association" => association_params}) do
    login = Guardian.Plug.current_resource(conn)
    if login.status != 2 do
      conn
      |> put_status(:unauthorized)
      |> json(%{error: "Login error"})
    else
      with {:ok, %Association{} = association} <- Teams.create_association(association_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.association_path(conn, :show, association))
        |> render("show.json", association: association)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    association = Teams.get_association!(id)
    render(conn, "show.json", association: association)
  end

  def update(conn, %{"id" => id, "association" => association_params}) do
    login = Guardian.Plug.current_resource(conn)
    if login.status != 2 do
      conn
      |> put_status(:unauthorized)
      |> json(%{error: "Login error"})
    else
      association = Teams.get_association!(id)

      with {:ok, %Association{} = association} <- Teams.update_association(association, association_params) do
        render(conn, "show.json", association: association)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    login = Guardian.Plug.current_resource(conn)
    if login.status != 2 do
      conn
      |> put_status(:unauthorized)
      |> json(%{error: "Login error"})
    else
      association = Teams.get_association!(id)

      with {:ok, %Association{}} <- Teams.delete_association(association) do
        send_resp(conn, :no_content, "")
      end
    end
  end
end
