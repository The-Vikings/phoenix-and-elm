defmodule PhoenixAndElm.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add(:first_name, :string)
      add(:last_name, :string)
      add(:gender, :integer)
      add(:birth_date, :date)
      add(:location, :string)
      add(:phone_number, :string)
      add(:email, :string)
      add(:headline, :text)
      add(:picture, :string)
      timestamps()
    end
  end
end
