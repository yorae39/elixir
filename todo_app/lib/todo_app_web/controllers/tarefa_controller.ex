defmodule TodoAppWeb.TarefaController do
  use TodoAppWeb, :controller

  alias TodoApp.{Tarefa, Repo}

  def new(conn, _params) do
    IO.inspect conn

    changeset = Tarefa.changeset(%Tarefa{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"tarefa" => tarefa}) do
    changeset = Tarefa.changeset(%Tarefa{}, tarefa)
    case Repo.insert changeset do
      {:ok, struct} ->
        conn
        |> put_flash(:info, "Tarefa inserida com sucesso na lista: #{struct.titulo}")
        |> redirect(to: Routes.tarefa_path(conn, :index))
      {:error, changeset} ->  render conn, "new.html", changeset: changeset
    end
  end

  def index(conn, _params) do
    render conn, "index.html", tarefas: Repo.all(Tarefa)
  end

end
