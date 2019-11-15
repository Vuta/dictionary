defmodule DictionaryWeb.PostController do
  use DictionaryWeb, :controller

  alias Dictionary.Post

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def new(conn, _params) do
    post = Post.changeset(%Post{})

    render(conn, "new.html", post: post)
  end

  def create(conn, %{"post" => attrs}) do
    case Post.create(attrs) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Successfully")
        |> redirect(to: Routes.post_path(conn, :show, post))

      _ ->
        json(conn, "Bad Request")
    end
  end

  def show(conn, %{"id" => id}) do
    case Post.find(id) do
      nil -> json(conn, "Not found")

      post -> render(conn, "show.html", post: post)
    end
  end

  def edit(conn, %{"id" => id}) do
    case Post.find(id) do
      nil -> json(conn, "Not found")

      post -> render(conn, "edit.html", post: post, changeset: Post.changeset(post))
    end
  end

  def update(conn, %{"id" => id, "post" => attrs}) do
    case Post.find(id) do
      nil -> json(conn, "Not found")

      post ->
        case Post.update(post, attrs) do
          {:ok, post} ->
            redirect(conn, to: Routes.post_path(conn, :show, post))

          _ -> json(conn, "Bad Request")
        end
    end
  end
end
