defmodule ElixirTw.Router do
  use ElixirTw.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", ElixirTw do
    pipe_through :browser # Use the default browser stack

    #get "/", PostController, :index
    get "/", PageController, :landing

    get "/login", SessionController, :new
    delete "/logout", SessionController, :delete

    resources "/posts", PostController, only: [:index, :show]
  end

  scope "/auth", ElixirTw do
    pipe_through :browser

    get "/:provider", SessionController, :request
    get "/:provider/callback", SessionController, :callback
    post "/:provider/callback", SessionController, :callback
  end

  scope "/user", ElixirTw.User, as: :user do
    pipe_through [:browser, :auth]

    resources "/posts", PostController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ElixirTw do
  #   pipe_through :api
  # end
end
