defmodule BssWeb.Order do
  use BssWeb.Web, :model

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

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:first_name, :last_name, :address_line_1, :address_line_2, :city, :state, :zip, :email, :status])
    |> validate_required([:first_name, :last_name, :address_line_1, :address_line_2, :city, :state, :zip, :email, :status])
  end
end
