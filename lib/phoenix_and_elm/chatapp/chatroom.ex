defmodule PhoenixAndElm.Chatapp.Chatroom do
  use Ecto.Schema
  import Ecto.Changeset


  schema "chatrooms" do
    field :name, :string
    has_many :questions, PhoenixAndElm.Chatapp.Question
#    has_many :users, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(chatroom, attrs) do
    chatroom
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
