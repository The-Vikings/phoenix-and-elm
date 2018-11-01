defmodule PhoenixAndElmWeb.QuestionController do
  use PhoenixAndElmWeb, :controller

  alias PhoenixAndElm.Chatapp
  alias PhoenixAndElm.Chatapp.Question

  action_fallback PhoenixAndElmWeb.FallbackController

  def index(conn, _params) do
    questions = Chatapp.list_questions()
    render(conn, "index.json", questions: questions)
  end

  def create(conn, %{"question" => question_params}) do
    with {:ok, %Question{} = question} <- Chatapp.create_question(question_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", question_path(conn, :show, question))
      |> render("show.json", question: question)
    end
  end

  def show(conn, %{"id" => id}) do
    question = Chatapp.get_question!(id)
    render(conn, "show.json", question: question)
  end

  def update(conn, %{"id" => id, "question" => question_params}) do
    question = Chatapp.get_question!(id)

    with {:ok, %Question{} = question} <- Chatapp.update_question(question, question_params) do
      render(conn, "show.json", question: question)
    end
  end

  def delete(conn, %{"id" => id}) do
    question = Chatapp.get_question!(id)
    with {:ok, %Question{}} <- Chatapp.delete_question(question) do
      send_resp(conn, :no_content, "")
    end
  end
end
