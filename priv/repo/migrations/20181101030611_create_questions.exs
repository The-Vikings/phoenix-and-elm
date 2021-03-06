defmodule PhoenixAndElm.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :body, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :chatroom_id, references(:chatrooms, on_delete: :nothing)

      timestamps()
    end

    create index(:questions, [:user_id])
  end
end
