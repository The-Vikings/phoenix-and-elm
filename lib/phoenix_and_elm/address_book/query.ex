defmodule PhoenixAndElm.AddressBook.Query do
  @moduledoc false

  import Ecto.Query, warn: false
  alias PhoenixAndElm.AddressBook.Contact

  @contact_search_tsvector """
  (
    to_tsvector(
      'english',
      coalesce(first_name, '') || ' ' ||
      coalesce(last_name, '') || ' ' ||
      coalesce(location, '') || ' ' ||
      coalesce(headline, '') || ' ' ||
      coalesce(email, '') || ' ' ||
      coalesce(phone_number, '')
    )
    @@ to_tsquery('english', ?)
  )
  """

  def search_contacts(""), do: Contact

  def search_contacts(query) do
    query = tsquery_format(query)

    Contact
    |> where(fragment(@contact_search_tsvector, ^query))
  end

  defp tsquery_format(query) do
    query
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(&"#{&1}:*")
    |> Enum.join(" & ")
  end
end
