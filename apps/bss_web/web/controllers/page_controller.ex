defmodule BssWeb.PageController do
  use BssWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
