defmodule BssWeb.TestHelpers do
  alias BssWeb.Repo

  def insert_user(attrs \\ %{}) do
    changes = Dict.merge(%{
      name: "Some User",
      username: "user#{Base.encode16(:crypto.strong_rand_bytes(8))}",
      password: "supersecret",
      admin: false
    }, attrs)

    %BssWeb.User{}
    |> BssWeb.User.registration_changeset(changes)
    |> Repo.insert!()
  end

  def insert_order(attrs \\ %{}) do
    %BssWeb.Order{}
    |> BssWeb.Order.changeset(attrs)
    |> Repo.insert!()
  end
end