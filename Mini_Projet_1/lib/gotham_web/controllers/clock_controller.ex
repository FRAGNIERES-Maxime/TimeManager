defmodule CityWeb.ClockController do
  use CityWeb, :controller

  alias City.Cloakeur
  alias City.Cloakeur.Clock

  action_fallback CityWeb.FallbackController

  def index(conn, _params) do
    clocks = Cloakeur.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"clock" => clock_params}) do
    with {:ok, %Clock{} = clock} <- Cloakeur.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end

  def show(conn, %{"id" => id}) do
    clock = Cloakeur.get_clock!(id)
    render(conn, "show.json", clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Cloakeur.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Cloakeur.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def createOrDelete(conn, id) do

    login = Guardian.Plug.current_resource(conn)
    clock = Cloakeur.createOrDelete(id)
    send_resp(conn, :no_content, "")
  end

  def delete(conn, %{"id" => id}) do
    clock = Cloakeur.get_clock!(id)

    with {:ok, %Clock{}} <- Cloakeur.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
