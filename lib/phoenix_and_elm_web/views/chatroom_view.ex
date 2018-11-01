defmodule PhoenixAndElmWeb.ChatroomView do
  use PhoenixAndElmWeb, :view
  alias PhoenixAndElmWeb.ChatroomView

  def render("index.json", %{chatrooms: chatrooms}) do
    %{data: render_many(chatrooms, ChatroomView, "chatroom.json")}
  end

  def render("show.json", %{chatroom: chatroom}) do
    %{data: render_one(chatroom, ChatroomView, "chatroom.json")}
  end

  def render("chatroom.json", %{chatroom: chatroom}) do
    %{id: chatroom.id,
      name: chatroom.name}
  end
end
