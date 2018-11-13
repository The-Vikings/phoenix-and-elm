defmodule PhoenixAndElmWeb.VoteController do
  use PhoenixAndElmWeb, :controller
  use PhoenixSwagger

  alias PhoenixAndElm.Chatapp
  alias PhoenixAndElm.Chatapp.Vote

  action_fallback PhoenixAndElmWeb.FallbackController

  def index(conn, _params) do
    votes = Chatapp.list_votes()
    render(conn, "index.json", votes: votes)
  end

  def create(conn, %{"vote" => vote_params}) do
    with {:ok, %Vote{} = vote} <- Chatapp.create_vote(vote_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", vote_path(conn, :show, vote))
      |> render("show.json", vote: vote)
    end
  end

  def show(conn, %{"id" => id}) do
    vote = Chatapp.get_vote!(id)
    render(conn, "show.json", vote: vote)
  end

  def update(conn, %{"id" => id, "vote" => vote_params}) do
    vote = Chatapp.get_vote!(id)

    with {:ok, %Vote{} = vote} <- Chatapp.update_vote(vote, vote_params) do
      render(conn, "show.json", vote: vote)
    end
  end

  def delete(conn, %{"id" => id}) do
    vote = Chatapp.get_vote!(id)
    with {:ok, %Vote{}} <- Chatapp.delete_vote(vote) do
      send_resp(conn, :no_content, "")
    end
  end

  def swagger_definitions do
    %{
      Vote: swagger_schema do
        title "Vote"
        description "A vote of the application"
        properties do
          name :string, "Votes name", required: true
          id :string, "Unique identifier", required: true
          inserted_at :string, "Creation timestamp", format: :datetime
          updated_at :string, "Update timestamp", format: :datetime
        end
        example %{
          value: 1,
          id: "123",
        }
      end,
      VoteRequest: swagger_schema do
        title "VoteRequest"
        description "POST body for creating a vote"
        property :vote, Schema.ref(:Vote), "The vote details"
      end,
      VoteResponse: swagger_schema do
        title "VoteResponse"
        description "Response schema for single vote"
        property :data, Schema.ref(:Vote), "The vote details"
      end,
      VotesResponse: swagger_schema do
        title "VotesReponse"
        description "Response schema for multiple votes"
        property :data, Schema.array(:Vote), "The votes details"
      end,
      Votes: swagger_schema do
        title "Votes"
        description "A collection of Votes"
        type :array
        items Schema.ref(:Vote)
      end
    }
  end

  swagger_path(:index) do
    get "/api/votes"
    summary "List Votes"
    description "List all votes in the database"
    produces "application/json"
    deprecated false
    response 200, "OK", Schema.ref(:VotesResponse), example: %{
      data: [
        %{id: 1, value: 1, inserted_at: "2017-02-08T12:34:55Z", updated_at: "2017-02-12T13:45:23Z"}
      ]
    }
  end

  swagger_path(:create) do
    post "/api/votes"
    summary "Create vote"
    description "Creates a new vote"
    consumes "application/json"
    produces "application/json"
    parameter :vote, :body, Schema.ref(:VoteRequest), "The vote details", example: %{
      vote: %{value: 1}
    }
    response 201, "Vote created OK", Schema.ref(:VoteResponse), example: %{
      data: %{
        id: 1, value: 1, inserted_at: "2017-02-08T12:34:55Z", updated_at: "2017-02-12T13:45:23Z"
      }
    }
  end
  swagger_path(:show) do
    summary "Show Vote"
    description "Show a vote by ID"
    produces "application/json"
    parameter :id, :path, :integer, "Vote ID", required: true, example: 123
    response 200, "OK", Schema.ref(:VoteResponse), example: %{
      data: %{
        id: 123, value: 1, inserted_at: "2017-02-08T12:34:55Z", updated_at: "2017-02-12T13:45:23Z"
      }
    }
  end
end
