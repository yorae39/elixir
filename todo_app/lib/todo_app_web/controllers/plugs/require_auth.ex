defmodule TodoAppWeb.Plug.RequireAuth do
  import Phoenix.Controller
  import Plug.Conn
  alias TodoAppWeb.Router.Helpers

  def init(_params) do

  end

  def call(conn, _params) do
    if (conn.assigns[:user]) do
        conn
    else
      conn
      |> put_flash(:error, "Você precisa estar logado!")
      |> redirect(to: Helpers.tarefa_path(conn, :index))
      |> halt
    end
  end

end
