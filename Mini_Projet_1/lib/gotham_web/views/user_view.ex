defmodule CityWeb.UserView do
  use CityWeb, :view
  alias CityWeb.UserView


  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      password_hash: user.password_hash,
      status: user.status,
      username: user.username}
  end

  def render("tmp.json", %{tmp: tmp})do
    %{rigth_to_route: tmp.rigth_to_route}
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end

end
