defmodule PhoenixAndElm.Chatapp.Question do
  use Ecto.Schema
  import Ecto.Changeset


  schema "questions" do
    field :body, :string
    field :user_id, :id
    field :chatroom_id, :id
   # belongs_to :chatrooms, PhoenixAndElm.Chatapp.Chatroom
    #has_many :replies, foreign_key: :question_id
    #has_many :


    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
