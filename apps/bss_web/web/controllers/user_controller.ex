defmodule BssWeb.UserController do
  use BssWeb.Web, :controller

  plug :authenticate when action in [:index, :show, :create, :new]
  plug :admin_only when action in [:create, :new]

  alias BssWeb.User

  def index(conn, _params) do
    users = Repo.all(User)
    render conn, "index.html", users: users
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    render conn, "show.html", user: user
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> BssWeb.Auth.login(user)
        |> put_flash(:info ,"#{user.name} created!")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: page_path(conn, :index))
      |> halt()
    end
  end

  defp admin_only(conn, _opts) do
    current_user = conn.assigns.current_user
    if current_user && current_user.admin do
      conn
    else
      conn
      |> put_flash(:error, "You must be an admin to do that")
      |> redirect(to: page_path(conn, :index))
      |> halt()
    end
  end
end
