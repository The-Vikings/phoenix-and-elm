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
    %{id: q.id,
      body: q.body,
      user_id: q.user_id,
      inserted_at: q.inserted_at,
      updated_at: q.updated_at,
      votes: Enum.map(q.votes, &render_votes(&1)),
      replies: Enum.map(q.replies, &render_replies(&1)),
      autoanswers: Enum.map(q.autoanswers, &render_autoanswers(&1))
    }
  end

  def render_votes(v) do
    %{value: v.value,
      user_id: v.user_id,
      question_id: v.question_id,
      inserted_at: v.inserted_at,
      updated_at: v.updated_at
    }
  end

  def render_replies(r) do
    %{body: r.body,
      user_id: r.user_id,
      question_id: r.question_id,
      inserted_at: r.inserted_at,
      updated_at: r.updated_at
    }
  end

  def render_autoanswers(r) do
    %{body: r.body,
      question_id: r.question_id,
      inserted_at: r.inserted_at,
      updated_at: r.updated_at
    }
  end

end
