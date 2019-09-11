defmodule CityWeb.Router do
  use CityWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end


  scope "/api", CityWeb do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]
    resources "/workingtimes", WorkingTimeController, except: [:new, :edit]

    post "/workingtimes/:id", WorkingTimeController, :createByUser
  end
end
