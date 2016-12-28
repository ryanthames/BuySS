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
  @tag login_as: "max"
  test "deletes order", %{conn: conn} do
    count_before = order_count(Order)
    some_order = insert_order(@valid_attrs)

    assert order_count(Order) == count_before + 1

    conn = delete(conn, order_path(conn, :delete, some_order.id))

    assert html_response(conn, 302)

    assert order_count(Order) == count_before

    refute Repo.get(Order, some_order.id)
  end

  @tag login_as: "max"
    test "edits shows order edit page", %{conn: conn} do
      order = insert_order(@valid_attrs)
      conn = get(conn, order_path(conn, :edit, order))
      assert html_response(conn, :ok) =~ ~r/Edit order.*#{order.email}/s
    end

  @tag login_as: "max"
  test "updates order and redirects", %{conn: conn} do
    some_order = insert_order(@valid_attrs)
    new_attrs = Map.put(@valid_attrs, :email, "test@whatever.com")

    conn = put(conn, order_path(conn, :update, some_order), order: new_attrs)
    assert html_response(conn, 302)
    assert Repo.get(Order, some_order.id).email == "test@whatever.com"
  end

  @tag login_as: "max"
    test "does not update invalid order", %{conn: conn} do
      order = insert_order(@valid_attrs)
      conn = put(conn, order_path(conn, :update, order), order: %{email: ""})
      assert html_response(conn, 200) =~ "check the errors"
      assert Repo.get(Order, order.id).email == order.email
    end

  defp order_count(query), do: Repo.one(from o in query, select: count(o.id))
end