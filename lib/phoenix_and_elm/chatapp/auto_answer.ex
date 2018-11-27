defmodule PhoenixAndElm.Chatapp.AutoAnswer do
  use Ecto.Schema
  import Ecto.Changeset


  schema "autoanswers" do
    field :body, :string
    field :question_id, :id

    timestamps()
  end

  @doc false
  def changeset(auto_answer, attrs) do
    auto_answer
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
