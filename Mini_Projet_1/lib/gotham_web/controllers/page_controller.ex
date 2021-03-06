defmodule CityWeb.PageController do
  use CityWeb, :controller

  def protected(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "protected.html", current_user: user)
  end
end
