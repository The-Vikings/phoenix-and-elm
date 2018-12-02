defmodule PhoenixAndElm.Repo.Migrations.CreateAutoanswers do
  use Ecto.Migration

  def change do
    create table(:autoanswers) do
      add :body, :string
      add :question_id, references(:questions, on_delete: :nothing)

      timestamps()
    end

    create index(:autoanswers, [:question_id])
  end
end
