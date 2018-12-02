defmodule PhoenixAndElmWeb.QuestionView do
  use PhoenixAndElmWeb, :view
  alias PhoenixAndElmWeb.QuestionView

  def render("index.json", %{questions: questions}) do
    %{data: render_many(questions, QuestionView, "question.json")}
  end

  def render("show.json", %{question: question}) do
    %{data: render_one(question, QuestionView, "question.json")}
  end

  def render("question.json", %{question: question}) do
    %{id: question.id,
      body: question.body,
      user_id: question.user_id,
      chatroom_id: question.chatroom_id}
  end
end
