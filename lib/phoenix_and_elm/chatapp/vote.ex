defmodule PhoenixAndElm.Chatapp.Vote do
  use Ecto.Schema
  import Ecto.Changeset


  schema "votes" do
    field :value, :integer, default: 0
    field :user_id, :id
    field :question_id, :id

    timestamps()
  end

  @doc false
  def changeset(vote, attrs) do
    vote
    |> cast(attrs, [:value])
    |> validate_required([:value])
  end
end
