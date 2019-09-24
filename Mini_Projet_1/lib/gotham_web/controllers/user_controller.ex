defmodule CityWeb.UserController do
  use CityWeb, :controller

  alias City.Accounts
  alias City.Accounts.User


  alias City.Guardian

  action_fallback CityWeb.FallbackController

  def index(conn, _params) do

    mana = Guardian.Plug.current_resource(conn)
    if mana.status == 1 do
      users = Accounts.get_list_by_manager(mana.id)
    else
      users = Accounts.list_users()
    end
    render(conn, "index.json", users: users)
  end

  def userbymanager(conn, %{"id" => id}) do
    login = Guardian.Plug.current_resource(conn)
    if login.status == 2 do
      users = Accounts.get_list_by_manager(String.to_integer(id))
      render(conn, "index.json", users: users)
    else
      send(conn, :error);
    end

  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
           conn |> render("jwt.json", jwt: token)
    end
  end

  def auth(conn, %{"id" => id})do
    mana = Guardian.Plug.current_resource(conn)
    user = Accounts.autorize(mana.id, id)
    render(conn, "index.json", users: user)
  end



  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    conn |> render("user.json", user: user)
 end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Accounts.token_sign_in(email, password) do
      {:ok, token, _claims} ->
        conn |> render("jwt.json", jwt: token)
      _ ->
        {:error, :unauthorized}
    end
  end


end
