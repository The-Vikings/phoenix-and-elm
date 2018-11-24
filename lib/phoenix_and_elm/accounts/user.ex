defmodule PhoenixAndElm.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :name, :string
    field :chatroom_id, :id

    has_many :votes, PhoenixAndElm.Chatapp.Vote
    has_many :replies, PhoenixAndElm.Chatapp.Reply
    has_many :questions, PhoenixAndElm.Chatapp.Question

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
