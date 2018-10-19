defmodule PhoenixAndElmWeb.V1.ContactController do
  use PhoenixAndElmWeb, :controller
  alias PhoenixAndElm.AddressBook

  def index(conn, params) do
    contacts = AddressBook.list_contacts(params)
    json(conn, contacts)
  end

  def show(conn, %{"id" => id}) do
    contact = AddressBook.get_contact!(id)
    json(conn, contact)
  end
end
