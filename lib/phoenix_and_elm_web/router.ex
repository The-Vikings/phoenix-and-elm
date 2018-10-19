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

    scope "/v1", V1 do
      resources "/contacts", ContactController, only: [:index, :show]
    end
  end

  scope "/", PhoenixAndElmWeb do
    # Use the default browser stack
    pipe_through :browser

    get "/*path", AddressBookController, :index
  end
end
