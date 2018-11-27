defmodule PhoenixAndElmWeb.AutoAnswerView do
  use PhoenixAndElmWeb, :view
  alias PhoenixAndElmWeb.AutoAnswerView

  def render("index.json", %{autoanswers: autoanswers}) do
    %{data: render_many(autoanswers, AutoAnswerView, "auto_answer.json")}
  end

  def render("show.json", %{auto_answer: auto_answer}) do
    %{data: render_one(auto_answer, AutoAnswerView, "auto_answer.json")}
  end

  def render("auto_answer.json", %{auto_answer: auto_answer}) do
    %{id: auto_answer.id,
      body: auto_answer.body}
  end
end
