defmodule BssWeb.Repo.Migrations.CreateOrder do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :first_name, :string
      add :last_name, :string
      add :address_line_1, :string
      add :address_line_2, :string
      add :city, :string
      add :state, :string
      add :zip, :integer
      add :email, :string
      add :status, :string

      timestamps()
    end

  end
end
