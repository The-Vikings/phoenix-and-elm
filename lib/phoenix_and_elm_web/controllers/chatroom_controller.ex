defmodule PhoenixAndElmWeb.ChatroomController do
  use PhoenixAndElmWeb, :controller

  alias PhoenixAndElm.Chatapp
  alias PhoenixAndElm.Chatapp.Chatroom

  action_fallback PhoenixAndElmWeb.FallbackController

  def index(conn, _params) do
    chatrooms = Chatapp.list_chatrooms()
    render(conn, "index.json", chatrooms: chatrooms)
  end

  def create(conn, %{"chatroom" => chatroom_params}) do
    with {:ok, %Chatroom{} = chatroom} <- Chatapp.create_chatroom(chatroom_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", chatroom_path(conn, :show, chatroom))
      |> render("show.json", chatroom: chatroom)
    end
  end

  def show(conn, %{"id" => id}) do
    chatroom = Chatapp.get_chatroom!(id)
    render(conn, "show.json", chatroom: chatroom)
  end

  def update(conn, %{"id" => id, "chatroom" => chatroom_params}) do
    chatroom = Chatapp.get_chatroom!(id)

    with {:ok, %Chatroom{} = chatroom} <- Chatapp.update_chatroom(chatroom, chatroom_params) do
      render(conn, "show.json", chatroom: chatroom)
    end
  end

  def delete(conn, %{"id" => id}) do
    chatroom = Chatapp.get_chatroom!(id)
    with {:ok, %Chatroom{}} <- Chatapp.delete_chatroom(chatroom) do
      send_resp(conn, :no_content, "")
    end
  end
end
