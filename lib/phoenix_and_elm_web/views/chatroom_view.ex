defmodule PhoenixAndElmWeb.ChatroomView do
  use PhoenixAndElmWeb, :view
  alias PhoenixAndElmWeb.ChatroomView

  def render("index.json", %{chatrooms: chatrooms}) do
    %{data: render_many(chatrooms, ChatroomView, "chatroom.json")}
  end

  def render("show.json", %{chatroom: chatroom}) do
    %{data: render_one(chatroom, ChatroomView, "chatroom.json")}
  end

  def render("all.json", %{chatroom: chatroom}) do
    %{data: render_one(chatroom, ChatroomView, "chatroom_all.json")}
  end

  def render("chatroom.json", %{chatroom: chatroom}) do
    %{id: chatroom.id,
      name: chatroom.name
    }
  end
  def render("chatroom_all.json", %{chatroom: chatroom}) do
    %{id: chatroom.id,
      name: chatroom.name,
      questions: Enum.map(chatroom.questions, &render_question(&1))
    }
  end

  def render_question(q) do
    %{id: q.id, body: q.body}
  end

end
