defmodule BssWeb.OrderControllerTest do
  use BssWeb.ConnCase

  alias BssWeb.Order

  @valid_attrs %{
    first_name: "James",
    last_name: "Kirk",
    address_line_1: "123 Some St",
    city: "San Francisco",
    state: "CA",
    zip: 12345,
    email: "james.kirk@starfleet.gov"
  }

  @invalid_attrs %{
    first_name: "Hodor"
  }

  setup %{conn: conn} = config do
    if username = config[:login_as] do
      user = insert_user(username: username)
      conn = assign(build_conn(), :current_user, user)
      {:ok, conn: conn, user: user}
    else
      :ok
    end
  end

  test "requires user authentication on all non-create actions", %{conn: conn} do
    Enum.each([
      # new and create are available to the public...
      get(conn, order_path(conn, :index)),
      get(conn, order_path(conn, :show, "123")),
      get(conn, order_path(conn, :edit, "123")),
      put(conn, order_path(conn, :update, "123", %{})),
      delete(conn, order_path(conn, :delete, "123"))
    ], fn conn ->
      assert html_response(conn, 302)
      assert conn.halted
    end)
  end

  @tag login_as: "max"
  test "list all orders on index", %{conn: conn} do
    some_order = insert_order(%{
      first_name: "Bob",
      last_name: "Johnson",
      address_line_1: "123 Whatever Dr",
      city: "Whatever",
      state: "NY",
      zip: 12345,
      email: "bob.johnson@whatever.com"
    })

    another_order = insert_order(%{
      first_name: "Bill",
      last_name: "Smith",
      address_line_1: "543 Whatever Dr",
      city: "Whatever",
      state: "NY",
      zip: 12345,
      email: "bill.smith@whatever.com"
    })

    conn = get conn, order_path(conn, :index)
    assert html_response(conn, 200) =~ ~r/Listing orders/
    assert String.contains?(conn.resp_body, some_order.address_line_1)
    assert String.contains?(conn.resp_body, another_order.address_line_1)
  end

  # TODO test creating order
  # TODO test creating order with errors

  # TODO other CRUD actions

  defp order_count(query), do: Repo.one(from o in query, select: count(o.id))
end