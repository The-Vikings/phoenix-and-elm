defmodule PhoenixAndElmWeb.ReplyController do
  use PhoenixAndElmWeb, :controller

  alias PhoenixAndElm.Chatapp
  alias PhoenixAndElm.Chatapp.Reply

  action_fallback PhoenixAndElmWeb.FallbackController

  def index(conn, _params) do
    replies = Chatapp.list_replies()
    render(conn, "index.json", replies: replies)
  end

  def create(conn, %{"reply" => reply_params}) do
    with {:ok, %Reply{} = reply} <- Chatapp.create_reply(reply_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", reply_path(conn, :show, reply))
      |> render("show.json", reply: reply)
    end
  end

  def show(conn, %{"id" => id}) do
    reply = Chatapp.get_reply!(id)
    render(conn, "show.json", reply: reply)
  end

  def update(conn, %{"id" => id, "reply" => reply_params}) do
    reply = Chatapp.get_reply!(id)

    with {:ok, %Reply{} = reply} <- Chatapp.update_reply(reply, reply_params) do
      render(conn, "show.json", reply: reply)
    end
  end

  def delete(conn, %{"id" => id}) do
    reply = Chatapp.get_reply!(id)
    with {:ok, %Reply{}} <- Chatapp.delete_reply(reply) do
      send_resp(conn, :no_content, "")
    end
  end
end
