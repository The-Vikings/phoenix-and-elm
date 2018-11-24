defmodule PhoenixAndElm.Chatapp.Question do
  use Ecto.Schema
  import Ecto.Changeset


  schema "questions" do
    field :body, :string
    field :user_id, :id
    field :chatroom_id, :id
    has_many :replies, PhoenixAndElm.Chatapp.Reply
    has_many :votes, PhoenixAndElm.Chatapp.Vote

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
