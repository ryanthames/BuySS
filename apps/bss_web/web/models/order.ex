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

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:first_name, max: 50)
    |> validate_length(:last_name, max: 50)
    |> validate_length(:address_line_1, max: 100)
    |> validate_length(:city, max: 50)
    |> validate_length(:state, max: 2)
    |> validate_length(:email, max: 255)
    |> validate_format(:email, ~r/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
    # TODO validate zip format
    #|> validate_format(:zip, ~r/\A\d{5}(-\d{4})?\z/)
  end
end
