defmodule PhoenixAndElmWeb.Router do
  use PhoenixAndElmWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PhoenixAndElmWeb do
    pipe_through :api

    resources "/chatrooms", ChatroomController #, except: [:new, :edit]
    resources "/users", UserController #, except: [:new, :edit]
    resources "/questions", QuestionController #, except: [:new, :edit]
    resources "/replies", ReplyController #, except: [:new, :edit]
    resources "/votes", VoteController #, except: [:new, :edit]
  end
  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :phoenix_and_elm, swagger_file: "swagger.json", opts: [disable_validator: true]
  end

  scope "/", PhoenixAndElmWeb do
    # Use the default browser stack
    pipe_through :browser
  end
  def swagger_info do
    %{

      info: %{
	version: "0.1",
	title: "Leia App"
      }
    }
  end
end
