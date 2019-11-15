defmodule Dictionary.Repo.Migrations.CreatePostTable do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :term, :string
      add :description, :text

      timestamps()
    end
  end
end
