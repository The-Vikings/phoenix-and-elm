defmodule PhoenixAndElmWeb.ReplyController do
  use PhoenixAndElmWeb, :controller
  use PhoenixSwagger

  alias PhoenixAndElm.Chatapp
  alias PhoenixAndElm.Chatapp.Reply

  action_fallback PhoenixAndElmWeb.FallbackController

  def index(conn, _params) do
    replies = Chatapp.list_replies()
    render(conn, "index.json", replies: replies)
  end

  def create(conn, %{"reply" => reply_params}) do
    with {:ok, %Reply{} = reply} <- Chatapp.create_reply(reply_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", reply_path(conn, :show, reply))
      |> render("show.json", reply: reply)
    end
  end

  def show(conn, %{"id" => id}) do
    reply = Chatapp.get_reply!(id)
    render(conn, "show.json", reply: reply)
  end

  def update(conn, %{"id" => id, "reply" => reply_params}) do
    reply = Chatapp.get_reply!(id)

    with {:ok, %Reply{} = reply} <- Chatapp.update_reply(reply, reply_params) do
      render(conn, "show.json", reply: reply)
    end
  end

  def delete(conn, %{"id" => id}) do
    reply = Chatapp.get_reply!(id)
    with {:ok, %Reply{}} <- Chatapp.delete_reply(reply) do
      send_resp(conn, :no_content, "")
    end
  end

  def swagger_definitions do
    %{
      Reply: swagger_schema do
        title "Reply"
        description "A reply in the application"
        properties do
          name :string, "Reply's name", required: true
          id :string, "Unique identifier", required: true
          inserted_at :string, "Creation timestamp", format: :datetime
          updated_at :string, "Update timestamp", format: :datetime
        end
        example %{
          name: "CS443",
          id: "123",
        }
      end,
      Replies: swagger_schema do
        title "Replies"
        description "A collection of Replies"
        type :array
        items Schema.ref(:Reply)
      end,
      ReplyRequest: swagger_schema do
        title "ReplyRequest"
        description "POST body for creating a reply"
        property :reply, Schema.ref(:Reply), "The reply details"
      end,
      ReplyResponse: swagger_schema do
        title "ReplyResponse"
        description "Response schema for single reply"
        property :data, Schema.ref(:Reply), "The reply details"
      end,
      RepliesResponse: swagger_schema do
        title "RepliesReponse"
        description "Response schema for multiple replies"
        property :data, Schema.array(:Reply), "The replies details"
      end,

    }
  end

  swagger_path(:index) do
    get "/api/replies"
    summary "List Replies"
    description "List all replies in the database"
    produces "application/json"
    deprecated false
    response 200, "OK", Schema.ref(:RepliesResponse), example: %{
      data: [
        %{id: 1, body: "Check Raft's paper", inserted_at: "2017-02-08T12:34:55Z", updated_at: "2017-02-12T13:45:23Z"}
      ]
    }
  end

  swagger_path(:create) do
    post "/api/replies"
    summary "Create reply"
    description "Creates a new reply"
    consumes "application/json"
    produces "application/json"
    parameter :reply, :body, Schema.ref(:ReplyRequest), "The reply details", example: %{
      reply: %{body: "Check Raft's paper"}
    }
    response 201, "Reply created OK", Schema.ref(:ReplyResponse), example: %{
      data: %{
        id: 1, body: "Check Raft's paper", inserted_at: "2017-02-08T12:34:55Z", updated_at: "2017-02-12T13:45:23Z"
      }
    }
  end
  swagger_path(:show) do
    summary "Show Reply"
    description "Show a reply by ID"
    produces "application/json"
    parameter :id, :path, :integer, "Reply ID", required: true, example: 123
    response 200, "OK", Schema.ref(:ReplyResponse), example: %{
      data: %{
        id: 123, body: "Check Raft's paper", inserted_at: "2017-02-08T12:34:55Z", updated_at: "2017-02-12T13:45:23Z"
      }
    }
  end
end
