defmodule PhoenixAndElmWeb.ReplyView do
  use PhoenixAndElmWeb, :view
  alias PhoenixAndElmWeb.ReplyView

  def render("index.json", %{replies: replies}) do
    %{data: render_many(replies, ReplyView, "reply.json")}
  end

  def render("show.json", %{reply: reply}) do
    %{data: render_one(reply, ReplyView, "reply.json")}
  end

  def render("reply.json", %{reply: reply}) do
    %{id: reply.id,
      body: reply.body}
  end
end
