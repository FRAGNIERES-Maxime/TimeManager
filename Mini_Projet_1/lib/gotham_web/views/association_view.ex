defmodule CityWeb.AssociationView do
  use CityWeb, :view
  alias CityWeb.AssociationView

  def render("index.json", %{associations: associations}) do
    %{data: render_many(associations, AssociationView, "association.json")}
  end

  def render("show.json", %{association: association}) do
    %{data: render_one(association, AssociationView, "association.json")}
  end

  def render("association.json", %{association: association}) do
    %{id: association.id,
      id_manager: association.id_manager,
      id_user: association.id_user}
  end
end
