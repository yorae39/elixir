defmodule Fatura do

  @moduledoc """
    Neste módulo executamos funções de fatura
  """

  @doc """
    Ao receber uma `fatura` retorna um array de faturas
      ## Exemplos
      iex> Fatura.criar_fatura(["Telefone", "Agua", "Luz"])
      ["Telefone", "Agua", "Luz"]
  """
  def criar_fatura(fatura) do
    fatura
  end
@doc """
  Ao receber `faturas` ordena as mesmas
"""
  def ordena_fatura(faturas) do
    Enum.sort(faturas)
  end
end
