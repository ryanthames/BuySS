defmodule BssWeb.User do
  use BssWeb.Web, :model

  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :admin, :boolean

    timestamps
  end
end
