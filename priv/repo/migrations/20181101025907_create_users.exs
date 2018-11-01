defmodule PhoenixAndElm.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :chatroom_id, references(:chatrooms, on_delete: :nothing)

      timestamps()
    end

    create index(:users, [:chatroom_id])
  end
end
