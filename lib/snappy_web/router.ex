defmodule SnappyWeb.Router do
  use SnappyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Snappy.Plugs.SetAuth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SnappyWeb do
    pipe_through :browser # Use the default browser stack

    get "/polls/chat/history", PollController, :history

    get "/", PollController, :index

    resources "/users", UserController

    resources "/polls", PollController, only: [:index, :show, :new, :create, :delete]
    get "/options/:id/vote", PollController, :vote 
  end

  scope "/auth", SnappyWeb do
    pipe_through :browser
    
    # Session routes
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
    get "/:provider", SessionController, :request
    get "/:provider/callback", SessionController, :callback
  end

  scope "/api", SnappyWeb do
    pipe_through :api

    resources "/polls", Api.PollController, only: [:index, :show]
  end
end
