defmodule Fatura do

  @moduledoc """
    Neste módulo executamos funções de fatura
  """

  @doc """
    Ao receber uma `fatura` retorna um array de faturas
      ## Exemplos
      iex> Fatura.criar_fatura(["Telefone", "Agua", "Luz"], [5, 10])
      ["Fatura: Telefone vence no dia: 5", "Fatura: Agua vence no dia: 5",
             "Fatura: Luz vence no dia: 5", "Fatura: Telefone vence no dia: 10",
             "Fatura: Agua vence no dia: 10", "Fatura: Luz vence no dia: 10"]
  """
  def criar_fatura(faturas, vencimentos) do
    for vencimento <- vencimentos, fatura <- faturas do
        "Fatura: #{fatura} vence no dia: #{vencimento}"
    end
 end

  @doc """
    Ao receber uma `fatura` e uma quantidade retorna um array de faturas apagar
      ## Exemplos
      iex> Fatura.faturas_a_pagar(Fatura.criar_fatura(["Telefone", "Agua", "Luz"], [5, 10]), 1)
      {["Fatura: Telefone vence no dia: 5"],
       ["Fatura: Agua vence no dia: 5", "Fatura: Luz vence no dia: 5",
        "Fatura: Telefone vence no dia: 10", "Fatura: Agua vence no dia: 10",
        "Fatura: Luz vence no dia: 10"]}
  """
 def faturas_a_pagar(faturas, quantidade) do
  Enum.split(faturas, quantidade)
 end

  @doc """
    Ao receber uma `fatura`, um vencimento e uma quantidade retorna um array de faturas pagas
      ## Exemplos
      iex(19)> Fatura.pagar_fatura(["Telefone", "Agua", "Luz"], [5, 10], 1)
      {["Fatura: Agua vence no dia: 10"],
      ["Fatura: Agua vence no dia: 5", "Fatura: Luz vence no dia: 10",
        "Fatura: Luz vence no dia: 5", "Fatura: Telefone vence no dia: 10",
        "Fatura: Telefone vence no dia: 5"]}
  """
 def pagar_fatura(faturas, vencimento, quantidade) do
   criar_fatura(faturas, vencimento)
   |> ordena_fatura()
   |> faturas_a_pagar(quantidade)
 end

  @doc """
    Salva faturas em um arquivo
      ## Exemplos

      iex> Fatura.save("Teste", Fatura.criar_fatura(["Telefone", "Agua", "Luz"], [5, 10]))
      :ok
  """
 def save(nome_arquivo, faturas) do
   binary = :erlang.term_to_binary(faturas)
   File.write(nome_arquivo, binary)
 end

  @doc """
    Salva faturas em um arquivo
      ## Exemplos

      iex(9)> Fatura.load("Teste")
      ["Fatura: Telefone vence no dia: 5", "Fatura: Agua vence no dia: 5",
      "Fatura: Luz vence no dia: 5", "Fatura: Telefone vence no dia: 10",
      "Fatura: Agua vence no dia: 10", "Fatura: Luz vence no dia: 10"]
  """
 def load(nome_arquivo) do
  case File.read(nome_arquivo) do
   {:ok, binario}  ->  :erlang.binary_to_term(binario)
   {:error, _erro} -> "Nao foi possivel carregar o arquivo"
  end

 end


@doc """
  Ao receber `faturas` ordena as mesmas
    ## Exemplos
    iex> Fatura.ordena_fatura(Fatura.criar_fatura(["Telefone", "Agua", "Luz"], [5, 10]))
    ["Fatura: Agua vence no dia: 10", "Fatura: Agua vence no dia: 5",
     "Fatura: Luz vence no dia: 10", "Fatura: Luz vence no dia: 5",
     "Fatura: Telefone vence no dia: 10", "Fatura: Telefone vence no dia: 5"]
"""
def ordena_fatura(faturas) do
  Enum.sort(faturas)
end

@doc """
   Ao receber `faturas` verifica se uma `fatura` existe dentro do Array
    ## Exemplos
    iex> Fatura.fatura_existe?(Fatura.criar_fatura(["Telefone", "Agua", "Luz"], [5, 10]), "Fatura: Agua vence no dia: 10")
    true
"""
def fatura_existe?(faturas, fatura) do
   Enum.member?(faturas, fatura)
end


end
