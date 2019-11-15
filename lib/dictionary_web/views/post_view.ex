defmodule DictionaryWeb.PostView do
  use DictionaryWeb, :view

  def markdown(body) do
    body
    |> Earmark.as_html!()
    |> raw()
  end
end
