defmodule PhoenixAndElmWeb.ChatroomController do
  use PhoenixAndElmWeb, :controller
  use PhoenixSwagger

  alias PhoenixAndElm.Chatapp
  alias PhoenixAndElm.Chatapp.Chatroom

  action_fallback PhoenixAndElmWeb.FallbackController

  def index(conn, _params) do
    chatrooms = Chatapp.list_chatrooms()
    render(conn, "index.json", chatrooms: chatrooms)
  end

  def create(conn, %{"chatroom" => chatroom_params}) do
    with {:ok, %Chatroom{} = chatroom} <- Chatapp.create_chatroom(chatroom_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", chatroom_path(conn, :show, chatroom))
      |> render("show.json", chatroom: chatroom)
    end
  end

  def show(conn, %{"id" => id}) do
    chatroom = Chatapp.get_chatroom!(id)
    render(conn, "show.json", chatroom: chatroom)
  end

  def update(conn, %{"id" => id, "chatroom" => chatroom_params}) do
    chatroom = Chatapp.get_chatroom!(id)

    with {:ok, %Chatroom{} = chatroom} <- Chatapp.update_chatroom(chatroom, chatroom_params) do
      render(conn, "show.json", chatroom: chatroom)
    end
  end

  def delete(conn, %{"id" => id}) do
    chatroom = Chatapp.get_chatroom!(id)
    with {:ok, %Chatroom{}} <- Chatapp.delete_chatroom(chatroom) do
      send_resp(conn, :no_content, "")
    end
  end

  def swagger_definitions do
    %{
      Chatroom: swagger_schema do
        title "Chatroom"
        description "A chatroom in the application"
        properties do
          name :string, "Chatroom's name", required: true
          id :string, "Unique identifier", required: true
        end
        example %{
          name: "CS443",
          id: "123",
        }
      end,
      Chatrooms: swagger_schema do
        title "Chatrooms"
        description "A collection of Chatrooms"
        type :array
        items Schema.ref(:Chatroom)
      end,
      ChatroomRequest: swagger_schema do
        title "ChatroomRequest"
        description "POST body for creating a chatroom"
        property :chatroom, Schema.ref(:Chatroom), "The chatroom details"
      end,
      ChatroomResponse: swagger_schema do
        title "ChatroomResponse"
        description "Response schema for single chatroom"
        property :data, Schema.ref(:Chatroom), "The chatroom details"
      end,
      ChatroomsResponse: swagger_schema do
        title "ChatroomsReponse"
        description "Response schema for multiple chatrooms"
        property :data, Schema.array(:Chatroom), "The chatrooms details"
      end,

    }
  end
  swagger_path(:create) do
    post "/api/chatrooms"
    summary "Create chatroom"
    description "Creates a new chatroom"
    consumes "application/json"
    produces "application/json"
    parameter :chatroom, :body, Schema.ref(:UserRequest), "The chatroom details", example: %{
      chatroom: %{name: "CS443"}
    }
    response 201, "Chatroom created OK", Schema.ref(:ChatroomResponse), example: %{
      data: %{
        id: 1, name: "CS443", inserted_at: "2017-02-08T12:34:55Z", updated_at: "2017-02-12T13:45:23Z"
      }
    }
  end
  swagger_path(:show) do
    summary "Show Chatroom"
    description "Show a chatroom by ID"
    produces "application/json"
    parameter :id, :path, :integer, "Chatroom ID", required: true, example: 123
    response 200, "OK", Schema.ref(:ChatroomResponse), example: %{
      data: %{
        id: 123, name: "CS443", inserted_at: "2017-02-08T12:34:55Z", updated_at: "2017-02-12T13:45:23Z"
      }
    }
  end
end
