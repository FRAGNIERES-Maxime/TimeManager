defmodule CityWeb.WorkingTimeController do
  use CityWeb, :controller

  alias City.Timer
  alias City.Timer.WorkingTime

  alias City.Account

  action_fallback CityWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Timer.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end


  def createByUser(conn, %{"id" => id, "workingtime" => working_time_params}) do
    with {:ok, %WorkingTime{} = working_time} <- Timer.create_working_time(Account.get_user!(id), working_time_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.working_time_path(conn, :show, working_time))
      |> render("show.json", working_time: working_time)
    end
  end

  def create(conn, %{"workingtime" => working_time_params}) do
    with {:ok, %WorkingTime{} = working_time} <- Timer.create_working_time(working_time_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.working_time_path(conn, :show, working_time))
      |> render("show.json", working_time: working_time)
    end
  end

  def getByUser(conn, %{"id" => id}) do
    working_times = Timer.list_workingtimes_by_id(id)
    render(conn, "index.json", workingtimes: working_times)
  end

  def show(conn, %{"id" => id}) do
    working_time = Timer.get_working_time!(id)
    render(conn, "show.json", working_time: working_time)
  end

  def update(conn, %{"id" => id, "workingtime" => working_time_params}) do
    working_time = Timer.get_working_time!(id)

    with {:ok, %WorkingTime{} = working_time} <- Timer.update_working_time(working_time, working_time_params) do
      render(conn, "show.json", working_time: working_time)
    end
  end

  def delete(conn, %{"id" => id}) do
    working_time = Timer.get_working_time!(id)

    with {:ok, %WorkingTime{}} <- Timer.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end
end
