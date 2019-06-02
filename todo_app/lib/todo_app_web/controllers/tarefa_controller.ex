defmodule TodoAppWeb.TarefaController do
  use TodoAppWeb, :controller


  alias TodoApp.Tarefa

  def new(conn, _params) do
    IO.inspect conn

    changeset = Tarefa.changeset(%Tarefa{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"tarefa" => tarefa}) do
    render conn, "tarefas.html", tarefa: tarefa
  end

end
