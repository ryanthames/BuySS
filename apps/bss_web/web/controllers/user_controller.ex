defmodule BssWeb.UserController do
  use BssWeb.Web, :controller

  def index(conn, _params) do
    users = Repo.all(BssWeb.User)
    render conn, "index.html", users: users
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(BssWeb.User, id)
    render conn, "show.html", user: user
  end
end
