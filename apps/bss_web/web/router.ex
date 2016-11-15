defmodule BssWeb.Router do
  use BssWeb.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug BssWeb.Auth, repo: BssWeb.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BssWeb do
    pipe_through :browser # Use the default browser stack
    get "/", PageController, :index
    resources "/users", UserController, only: [:index, :show, :new, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", BssWeb do
  #   pipe_through :api
  # end
end
