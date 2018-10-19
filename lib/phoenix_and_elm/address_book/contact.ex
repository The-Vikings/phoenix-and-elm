defmodule PhoenixAndElm.AddressBook.Contact do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  alias __MODULE__, as: Contact

  @derive {Poison.Encoder, except: [:__meta__, :inserted_at, :updated_at]}

  @genders [
    {0, :male},
    {1, :female}
  ]
  @required_params [
    :first_name,
    :last_name,
    :gender,
    :birth_date,
    :location,
    :phone_number,
    :email,
    :headline,
    :picture
  ]

  schema "contacts" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:gender, :integer)
    field(:birth_date, :date)
    field(:location, :string)
    field(:phone_number, :string)
    field(:email, :string)
    field(:headline, :string)
    field(:picture, :string)
    timestamps()
  end

  @doc false
  def changeset(%Contact{} = contact, attrs) do
    contact
    |> cast(attrs, @required_params)
    |> validate_required(@required_params)
  end

  @doc """
  Returns genders options
  """
  def genders, do: @genders
end
