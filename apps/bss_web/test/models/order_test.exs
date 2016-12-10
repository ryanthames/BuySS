defmodule BssWeb.OrderTest do
  use BssWeb.ModelCase

  alias BssWeb.Order

  @valid_attrs %{address_line_1: "some content", address_line_2: "some content", city: "some content", email: "some content", first_name: "some content", last_name: "some content", state: "some content", status: "some content", zip: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Order.changeset(%Order{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Order.changeset(%Order{}, @invalid_attrs)
    refute changeset.valid?
  end
end
