defmodule PhoenixAndElmWeb.QuestionController do
  use PhoenixAndElmWeb, :controller
  use PhoenixSwagger

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
    def swagger_definitions do
    %{
      Question: swagger_schema do
        title "Question"
        description "A question in the application"
        properties do
          name :string, "Question's name", required: true
          id :string, "Unique identifier", required: true
        end
        example %{
          name: "CS443",
          id: "123",
        }
      end,
      Questions: swagger_schema do
        title "Questions"
        description "A collection of Questions"
        type :array
        items Schema.ref(:Question)
      end,
      QuestionRequest: swagger_schema do
        title "QuestionRequest"
        description "POST body for creating a question"
        property :question, Schema.ref(:Question), "The question details"
      end,
      QuestionResponse: swagger_schema do
        title "QuestionResponse"
        description "Response schema for single question"
        property :data, Schema.ref(:Question), "The question details"
      end,
      QuestionsResponse: swagger_schema do
        title "QuestionsReponse"
        description "Response schema for multiple questions"
        property :data, Schema.array(:Question), "The questions details"
      end,

    }
  end
  swagger_path(:create) do
    post "/api/questions"
    summary "Create question"
    description "Creates a new question"
    consumes "application/json"
    produces "application/json"
    parameter :question, :body, Schema.ref(:UserRequest), "The question details", example: %{
      question: %{name: "CS443"}
    }
    response 201, "Question created OK", Schema.ref(:QuestionResponse), example: %{
      data: %{
        id: 1, body: "How does Raft's leader election work?", inserted_at: "2017-02-08T12:34:55Z", updated_at: "2017-02-12T13:45:23Z"
      }
    }
  end
  swagger_path(:show) do
    summary "Show Question"
    description "Show a question by ID"
    produces "application/json"
    parameter :id, :path, :integer, "Question ID", required: true, example: 123
    response 200, "OK", Schema.ref(:QuestionResponse), example: %{
      data: %{
        id: 123, body: "How does Raft's leader election work?", inserted_at: "2017-02-08T12:34:55Z", updated_at: "2017-02-12T13:45:23Z"
      }
    }
  end

end
