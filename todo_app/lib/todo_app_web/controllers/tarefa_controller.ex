defmodule TodoAppWeb.TarefaController do
  use TodoAppWeb, :controller

  alias TodoApp.{Tarefa, Repo}


  plug TodoAppWeb.Plug.RequireAuth when action in [:create, :update, :edit, :delete, :new]
  plug :verifica_permissao  when action in [:create, :update, :edit]


  def new(conn, _params) do
    changeset = Tarefa.changeset(%Tarefa{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"tarefa" => tarefa}) do
    changeset = conn.assigns.user
    |> Ecto.build_assoc(:tarefas)
    |> Tarefa.changeset(tarefa)
    case Repo.insert changeset do
      {:ok, struct} ->
        conn
        |> put_flash(:info, "Tarefa inserida com sucesso na lista: #{struct.titulo}")
        |> redirect(to: Routes.tarefa_path(conn, :index))
      {:error, changeset} ->  render conn, "new.html", changeset: changeset
    end
  end

  def index(conn, _params) do
   # IO.inspect conn.assigns
    render conn, "index.html", tarefas: Repo.all(Tarefa)
  end

  def edit(conn, %{"id" => tarefa_id}) do
    tarefa = Repo.get(Tarefa, tarefa_id)
    changeset = Tarefa.changeset(tarefa)
    render conn, "edit.html", changeset: changeset, tarefa: tarefa
  end

  def update(conn,  %{"tarefa" => tarefa, "id" => id}) do
    tarefa_alterar = Repo.get(Tarefa, id)
    changeset = Tarefa.changeset(tarefa_alterar, tarefa)

    case Repo.update(changeset) do
     {:ok, _struct} ->
      conn
        |> put_flash(:info, "Tarefa com id: #{id} alterada com sucesso!")
        |> redirect(to: Routes.tarefa_path(conn, :index))
     {:error, changeset} -> render conn, "edit.html", changeset: changeset, tarefa: tarefa_alterar
    end
  end


  def delete(conn, %{"id" => id}) do
    Repo.get!(Tarefa, id)
    |> Repo.delete!
      conn
    |> put_flash(:info, "Tarefa com id: #{id} excluida com sucesso!")
    |> redirect(to: Routes.tarefa_path(conn, :index))
  end

  def verifica_permissao(conn, _params) do
    %{params: %{"id" => tarefa_id}} = conn

    if Repo.get(Tarefa, tarefa_id).usuario_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "Você não pode executar esta operação!")
      |> redirect(to: Routes.tarefa_path(conn, :index))
      |> halt
    end
  end

end
