defmodule DictionaryWeb.Router do
  use DictionaryWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DictionaryWeb do
    pipe_through :browser

    get "/", PostController, :index
    resources "/posts", PostController
  end
end
