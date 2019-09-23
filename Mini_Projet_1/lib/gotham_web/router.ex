defmodule CityWeb.Router do
  use CityWeb, :router
  alias City.Guardian

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/api", CityWeb do
    pipe_through :api

    post "/sign_up", UserController, :create
    post "/sign_in", UserController, :sign_in
  end

  scope "/api", CityWeb do
    pipe_through [:api, :jwt_authenticated]
    resources "/users", UserController, only: [:create, :show, :index]
    resources "/workingtimes", WorkingTimeController, except: [:new, :edit, :show]
    options   "/users", UserController, :options
    post "/workingtimes/:id", WorkingTimeController, :createByUser
    get "/workingtimes/:id", WorkingTimeController, :getByUser
    post "/clocks/:id", ClockController, :createOrDelete
    get "/clocks/:id", ClockController, :show
    get "/me", UserController, :show
  end


end
