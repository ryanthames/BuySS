defmodule BssWeb.Repo do
  #use Ecto.Repo, otp_app: :bss_web
  @moduledoc """
  In memory repository
  """
  def all(BssWeb.User) do
    [%BssWeb.User{id: "1", name: "Ryan Thames", username: "ryanthames", password: "foobar", admin: true},
    %BssWeb.User{id: "2", name: "James Kirk", username: "jameskirk", password: "foobar", admin: false},
    %BssWeb.User{id: "3", name: "Jean-Luc Picard", username: "jeanlucpicard", password: "foobar", admin: false}]
  end

  def all(_module), do: []

  def get(module, id) do
    Enum.find all(module), fn map -> map.id == id end
  end

  def get_by(module, params) do
    Enum.find all(module), fn map ->
      Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
    end
  end
end
