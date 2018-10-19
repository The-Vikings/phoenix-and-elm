defmodule PhoenixAndElm.AddressBook do
  @moduledoc """
  The AddressBook context.
  """

  import Ecto.Query, warn: false
  alias PhoenixAndElm.AddressBook.{Contact, Query}
  alias PhoenixAndElm.Repo

  def list_contacts(%{"search" => query} = params) do
    query
    |> Query.search_contacts()
    |> order_by(:first_name)
    |> Repo.paginate(params)
  end

  def get_contact!(id) do
    Contact
    |> Repo.get!(id)
  end
end
