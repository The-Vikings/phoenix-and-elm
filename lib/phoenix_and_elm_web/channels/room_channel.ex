defmodule PhoenixAndElmWeb.RoomChannel do
  use PhoenixAndElmWeb, :channel
  alias PhoenixAndElm.Chatapp
  alias PhoenixAndElm.Chatapp.{Question, Reply, AutoAnswer, Vote}
  alias PhoenixAndElm.Repo
  def join("room:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("newVote", payload, socket) do
    {:ok, vote} = save_vote_to_database(payload)
    broadcast socket, "newVote", payload
    {:noreply, socket}
  end

  def handle_in("newReply", payload, socket) do
    reply = save_reply_to_database(payload)
    returnReply = %{
      user_id: 1,
      body: reply.body,
      question_id: reply.question_id,
      updated_at: reply.updated_at,
      inserted_at: reply.inserted_at 
    }
    broadcast socket, "newReply", returnReply
    {:noreply, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  def handle_in("newQuestion", payload, socket) do
    question = save_question_to_database(payload)

    spawn(fn -> automatic_query(payload, socket, question) end)

    returnQuestion = %{
      user_id: question.user_id,
      updated_at: question.updated_at,
      inserted_at: question.inserted_at,
      id: question.id,
      body: question.body
    }

    broadcast socket, "newQuestion", returnQuestion
    IO.inspect returnQuestion
    {:noreply, socket}
  end

  def automatic_query(payload, socket, question) do
    message = question.body
    url = "https://api.duckduckgo.com/?q=" <> message <> "&format=json&pretty=1?t=ABriefStudentProject"
    response = HTTPoison.get!(url).body
    |> Poison.decode!
    |> get_in(["RelatedTopics"])
    |> List.first
    |> get_in(["Text"])

    result = %{
      body: response,
      question_id: question.id
    }

    answer = Repo.insert! result

    return = %AutoAnswer{
      body: answer.body,
      question_id: answer.question_id,
      inserted_at: answer.inserted_at,
      updated_at: answer.updated_at
    }

    broadcast socket, "newAutoAnswer", return
  end

  def save_question_to_database(payload) do
    result = %Question{
      body: payload["body"],
      user_id: 1,
      chatroom_id: 1
    }
    #Chatapp.create_question(result)
    Repo.insert! result
  end

  def save_reply_to_database(payload) do
    result = %Reply{
      body: payload["body"],
      question_id: payload["question_id"],
      user_id: 1
    }
    Repo.insert! result
  end

  def save_vote_to_database(payload) do
    result = %Vote{
      value: payload["value"],
      question_id: payload["question_id"],
      user_id: 1
    }
    Repo.insert! result
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
