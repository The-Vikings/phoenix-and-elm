defmodule PhoenixAndElmWeb.ChatappController do
  use PhoenixAndElmWeb, :controller
  def index(conn, _params) do
    render(conn, "index.html")
  end
end
