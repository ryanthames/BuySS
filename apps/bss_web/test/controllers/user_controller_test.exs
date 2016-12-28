defmodule BssWeb.UserControllerTest do
  use BssWeb.ConnCase

  alias BssWeb.User

  @admin_attrs %{
    name: "Jean-Luc Picard",
    username: "jeanluc.picard",
    password: "123456",
    admin: true
  }

  @user_attrs %{
    name: "William Riker",
    username: "william.riker",
    password: "123456"
  }

  @invalid_attrs %{}

  setup %{conn: conn} = config do
    if username = config[:login_as] do
      if(config[:admin]) do
        user = insert_user(username: username, admin: true)
        conn = assign(build_conn(), :current_user, user)
        {:ok, conn: conn, user: user}
      else
        user = insert_user(username: username)
        conn = assign(build_conn(), :current_user, user)
        {:ok, conn: conn, user: user}
      end
    else
      :ok
    end
  end

  test "requires user authentication on all actions", %{conn: conn} do
    Enum.each([
      get(conn, user_path(conn, :index)),
      get(conn, user_path(conn, :new)),
      post(conn, user_path(conn, :create)),
      get(conn, user_path(conn, :show, "123"))
    ], fn conn ->
      assert html_response(conn, 302)
      assert conn.halted
    end)
  end

  @tag login_as: "max"
  test "requires admin authentication on some user actions", %{conn: conn} do
    Enum.each([
      get(conn, user_path(conn, :index)),
      get(conn, user_path(conn, :new)),
      post(conn, user_path(conn, :create))
    ], fn conn ->
      assert html_response(conn, 302)
      assert conn.halted
    end)
  end
end