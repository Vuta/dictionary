defmodule Dictionary.Post do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  alias Dictionary.Repo

  schema "posts" do
    field :term, :string
    field :description, :string

    timestamps()
  end

  def all_id_and_term() do
    query = from p in __MODULE__, order_by: p.term, select: [:id, :term]

    Repo.all(query)
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
    |> strip_unsafe_body(attrs)
  end

  defp strip_unsafe_body(post, %{"description" => nil}), do: post

  defp strip_unsafe_body(post, %{"description" => description}) do
    body =
      description
      |> Phoenix.HTML.html_escape()
      |> Phoenix.HTML.safe_to_string()

    put_change(post, :description, body)
  end

  defp strip_unsafe_body(post, _), do: post
end
