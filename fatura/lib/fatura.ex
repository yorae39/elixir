defmodule Fatura do

  @moduledoc """
    Neste módulo executamos funções de fatura
  """

  @doc """
    Ao receber uma `fatura` retorna um array de faturas
      ## Exemplos
      iex> Fatura.criar_fatura(["Telefone", "Agua", "Luz"], [5, 10])
      [
        %Fatura.Conta{fatura: "Telefone", vencimento: 5},
        %Fatura.Conta{fatura: "Agua", vencimento: 5},
        %Fatura.Conta{fatura: "Luz", vencimento: 5},
        %Fatura.Conta{fatura: "Telefone", vencimento: 10},
        %Fatura.Conta{fatura: "Agua", vencimento: 10},
        %Fatura.Conta{fatura: "Luz", vencimento: 10}
      ]
  """
  def criar_fatura(faturas, vencimentos) do
    for vencimento <- vencimentos, fatura <- faturas do
      %Fatura.Conta{fatura: fatura, vencimento: vencimento}
    end
 end

  @doc """
    Ao receber uma `fatura` e uma quantidade retorna um array de faturas apagar
      ## Exemplos
      iex> faturas = Fatura.criar_fatura(["Telefone", "Agua", "Luz"], [5, 10])
      iex> Fatura.faturas_a_pagar(faturas, 1)
      {[%Fatura.Conta{fatura: "Telefone", vencimento: 5}],
       [
         %Fatura.Conta{fatura: "Agua", vencimento: 5},
         %Fatura.Conta{fatura: "Luz", vencimento: 5},
         %Fatura.Conta{fatura: "Telefone", vencimento: 10},
         %Fatura.Conta{fatura: "Agua", vencimento: 10},
         %Fatura.Conta{fatura: "Luz", vencimento: 10}
       ]}
  """
 def faturas_a_pagar(faturas, quantidade) do
  Enum.split(faturas, quantidade)
 end

  @doc """
    Ao receber uma `fatura`, um vencimento e uma quantidade retorna um array de faturas pagas
    e salva o arquivo
  """
 def pagar_fatura(faturas, vencimento, quantidade, nome_arquivo) do
   criar_fatura(faturas, vencimento)
   |> ordena_fatura()
   |> faturas_a_pagar(quantidade)
   |> save(nome_arquivo)
 end

  @doc """
    Salva faturas em um arquivo
      ## Exemplos

      iex> Fatura.save("Teste", Fatura.criar_fatura(["Telefone", "Agua", "Luz"], [5, 10]))
      :ok
  """
 def save(faturas, nome_arquivo) do
   binary = :erlang.term_to_binary(faturas)
   File.write(nome_arquivo, binary)
 end

  @doc """
    Carrega um arquivo já salvo pelo seu nome
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
    iex> faturas = Fatura.criar_fatura(["Telefone", "Agua", "Luz"], [5, 10])
    iex> Fatura.ordena_fatura(faturas)
    [
      %Fatura.Conta{fatura: "Agua", vencimento: 5},
      %Fatura.Conta{fatura: "Agua", vencimento: 10},
      %Fatura.Conta{fatura: "Luz", vencimento: 5},
      %Fatura.Conta{fatura: "Luz", vencimento: 10},
      %Fatura.Conta{fatura: "Telefone", vencimento: 5},
      %Fatura.Conta{fatura: "Telefone", vencimento: 10}
    ]
"""
def ordena_fatura(faturas) do
  Enum.sort(faturas)
end

@doc """
   Ao receber `faturas` verifica se uma `fatura` existe dentro do Array
    ## Exemplos
     iex> faturas = Fatura.criar_fatura(["Telefone", "Agua", "Luz"], [5, 10])
     iex> Fatura.fatura_existe?(faturas, %Fatura.Conta{fatura: "Telefone", vencimento: 5})
     true
"""
def fatura_existe?(faturas, fatura) do
   Enum.member?(faturas, fatura)
end


end
