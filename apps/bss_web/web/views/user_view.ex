defmodule BssWeb.UserView do
  use BssWeb.Web, :view
  alias BssWeb.User

  def first_name(%User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end
end
