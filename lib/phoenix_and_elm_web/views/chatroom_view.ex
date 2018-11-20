defmodule PhoenixAndElmWeb.ChatroomView do
  use PhoenixAndElmWeb, :view
  alias PhoenixAndElmWeb.ChatroomView
  alias PhoenixAndElmWeb.QuestionView

  def render("index.json", %{chatrooms: chatrooms}) do
    %{data: render_many(chatrooms, ChatroomView, "chatroom.json")}
  end

  def render("show.json", %{chatroom: chatroom}) do
    %{data: render_one(chatroom, ChatroomView, "chatroom.json")}
  end

  def render("chatroom.json", %{chatroom: chatroom}) do
      %{id: chatroom.id,
        name: chatroom.name
    #    question: Enum.map(chatroom.questions, &render_question(&1))
        }
        #question: render_many(chatroom.questions, QuestionView, "question.json")}
      #if length(chatroom.questions) > 0 do
    #else
     # %{id: chatroom.id,
      #  name: chatroom.name}
    #end
  end
  def render_question(q) do
    %{id: q.id, body: q.body}
  end
end
