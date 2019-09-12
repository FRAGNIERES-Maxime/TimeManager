defmodule CityWeb.Router do
  use CityWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end


  scope "/api", CityWeb do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]
    resources "/workingtimes", WorkingTimeController, except: [:new, :edit, :show]

    options   "/users", UserController, :options
    post "/workingtimes/:id", WorkingTimeController, :createByUser
    get "/workingtimes/:id", WorkingTimeController, :getByUser

    post "/clocks/:id", ClockController, :createOrDelete

    get "/clocks/:id", ClockController, :show

  end
end
