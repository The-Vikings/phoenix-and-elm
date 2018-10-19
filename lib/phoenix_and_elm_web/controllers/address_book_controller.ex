defmodule PhoenixAndElmWeb.AddressBookController do
  use PhoenixAndElmWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
