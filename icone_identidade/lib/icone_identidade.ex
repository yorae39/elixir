defmodule IconeIdentidade do
  @moduledoc """
  Documentation for IconeIdentidade.
  """

  def main(entrada) do
    entrada
    |> hash_input()
  end

def hash_input(entrada) do
  hex = :crypto.hash(:md5, entrada)
  |> :binary.bin_to_list
  %IconeIdentidade.Imagem{hex: hex}
end


end
