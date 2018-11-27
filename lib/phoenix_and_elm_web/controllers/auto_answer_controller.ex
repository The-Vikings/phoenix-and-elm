defmodule PhoenixAndElmWeb.AutoAnswerController do
  use PhoenixAndElmWeb, :controller

  alias PhoenixAndElm.Chatapp
  alias PhoenixAndElm.Chatapp.AutoAnswer

  action_fallback PhoenixAndElmWeb.FallbackController

  def index(conn, _params) do
    autoanswers = Chatapp.list_autoanswers()
    render(conn, "index.json", autoanswers: autoanswers)
  end

  def create(conn, %{"auto_answer" => auto_answer_params}) do
    with {:ok, %AutoAnswer{} = auto_answer} <- Chatapp.create_auto_answer(auto_answer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", auto_answer_path(conn, :show, auto_answer))
      |> render("show.json", auto_answer: auto_answer)
    end
  end

  def show(conn, %{"id" => id}) do
    auto_answer = Chatapp.get_auto_answer!(id)
    render(conn, "show.json", auto_answer: auto_answer)
  end

  def update(conn, %{"id" => id, "auto_answer" => auto_answer_params}) do
    auto_answer = Chatapp.get_auto_answer!(id)

    with {:ok, %AutoAnswer{} = auto_answer} <- Chatapp.update_auto_answer(auto_answer, auto_answer_params) do
      render(conn, "show.json", auto_answer: auto_answer)
    end
  end

  def delete(conn, %{"id" => id}) do
    auto_answer = Chatapp.get_auto_answer!(id)
    with {:ok, %AutoAnswer{}} <- Chatapp.delete_auto_answer(auto_answer) do
      send_resp(conn, :no_content, "")
    end
  end
end
