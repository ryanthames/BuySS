defmodule BssWeb.OrderControllerTest do
  use BssWeb.ConnCase

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
end