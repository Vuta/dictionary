defmodule Dictionary.Post do
  use Ecto.Schema

  import Ecto.Changeset

  alias Dictionary.Repo

  schema "posts" do
    field :term, :string
    field :description, :string

    timestamps()
  end

  def find(id) do
    Repo.get(__MODULE__, id)
  end

  def create(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def update(post, attrs) do
    post
    |> changeset(attrs)
    |> Repo.update()
  end

  def changeset(post, attrs \\ %{}) do
    post
    |> cast(attrs, [:term, :description])
    |> validate_required([:term, :description])
  end
end
