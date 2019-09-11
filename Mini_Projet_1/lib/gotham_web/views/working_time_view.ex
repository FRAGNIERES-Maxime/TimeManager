defmodule CityWeb.WorkingTimeView do
  use CityWeb, :view
  alias CityWeb.WorkingTimeView

  def render("index.json", %{workingtimes: workingtimes}) do
    %{data: render_many(workingtimes, WorkingTimeView, "working_time.json")}
  end

  def render("show.json", %{working_time: working_time}) do
    %{data: render_one(working_time, WorkingTimeView, "working_time.json")}
  end

  def render("working_time.json", %{working_time: working_time}) do
    %{user: working_time.user_id,
      start: working_time.start,
      end: working_time.end}
  end
end
