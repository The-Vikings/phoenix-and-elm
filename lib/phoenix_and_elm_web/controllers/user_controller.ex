defmodule PhoenixAndElmWeb.UserController do
  use PhoenixAndElmWeb, :controller
  use PhoenixSwagger

  alias PhoenixAndElm.Accounts
  alias PhoenixAndElm.Accounts.User

  action_fallback PhoenixAndElmWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def swagger_definitions do
    %{
      User: swagger_schema do
        title "User"
        description "A user of the application"
        properties do
          name :string, "Users name", required: true
          inserted_at :string, "Creation timestamp", format: :datetime
          updated_at :string, "Update timestamp", format: :datetime
        end
        example %{
          name: "Joe",
          id: "123",
        }
      end,
      UserRequest: swagger_schema do
        title "UserRequest"
        description "POST body for creating a user"
        property :user, Schema.ref(:User), "The user details"
      end,
      UserResponse: swagger_schema do
        title "UserResponse"
        description "Response schema for single user"
        property :data, Schema.ref(:User), "The user details"
      end,
      UsersResponse: swagger_schema do
        title "UsersReponse"
        description "Response schema for multiple users"
        property :data, Schema.array(:User), "The users details"
      end,
      Users: swagger_schema do
        title "Users"
        description "A collection of Users"
        type :array
        items Schema.ref(:User)
      end
    }
  end
  swagger_path(:create) do
    post "/api/users"
    summary "Create user"
    description "Creates a new user"
    consumes "application/json"
    produces "application/json"
    parameter :user, :body, Schema.ref(:UserRequest), "The user details", example: %{
      user: %{name: "Joe"}
    }
    response 201, "User created OK", Schema.ref(:UserResponse), example: %{
      data: %{
        id: 1, name: "Joe", inserted_at: "2017-02-08T12:34:55Z", updated_at: "2017-02-12T13:45:23Z"
      }
    }
  end
  swagger_path(:show) do
    summary "Show User"
    description "Show a user by ID"
    produces "application/json"
    parameter :id, :path, :integer, "User ID", required: true, example: 123
    response 200, "OK", Schema.ref(:UserResponse), example: %{
      data: %{
        id: 123, name: "Joe", inserted_at: "2017-02-08T12:34:55Z", updated_at: "2017-02-12T13:45:23Z"
      }
    }
  end

end
