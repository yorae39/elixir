defmodule TodoApp.Usuario do
  use Ecto.Schema
  import Ecto.Changeset

  schema "usuarios" do
    field :nome, :string
    field :email, :string
    field :token, :string
    field :provider, :string
    timestamps()
  end


  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:nome, :email, :token, :provider])
    |> validate_required([:nome, :email, :token, :provider])
  end
end
