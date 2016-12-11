defmodule BssWeb.Order do
  use BssWeb.Web, :model

  @required_fields ~w(first_name last_name address_line_1 city state zip email)
  @optional_fields ~w(address_line_2)

  schema "orders" do
    field :first_name, :string
    field :last_name, :string
    field :address_line_1, :string
    field :address_line_2, :string
    field :city, :string
    field :state, :string
    field :zip, :integer
    field :email, :string
    field :status, :string

    timestamps()
  end
  
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
  end
end
