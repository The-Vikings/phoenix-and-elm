defmodule PhoenixAndElm.Chatapp.Chatroom do
  use Ecto.Schema
  import Ecto.Changeset


  schema "chatrooms" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(chatroom, attrs) do
    chatroom
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
