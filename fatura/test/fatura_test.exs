defmodule FaturaTest do
  use ExUnit.Case
  doctest Fatura

  test "deve criar uma lista de faturas" do
    faturas = Fatura.criar_fatura(["Telefone", "Agua", "Luz"], [5, 10])
    assert faturas == [
      %Fatura.Conta{fatura: "Telefone", vencimento: 5},
      %Fatura.Conta{fatura: "Agua", vencimento: 5},
      %Fatura.Conta{fatura: "Luz", vencimento: 5},
      %Fatura.Conta{fatura: "Telefone", vencimento: 10},
      %Fatura.Conta{fatura: "Agua", vencimento: 10},
      %Fatura.Conta{fatura: "Luz", vencimento: 10}
    ]
  end

  test "deve ordenar uma lista de faturas " do
    faturas = Fatura.criar_fatura(["Telefone", "Agua", "Luz"], [5, 10])
    assert Fatura.ordena_fatura(faturas) ==  [
      %Fatura.Conta{fatura: "Agua", vencimento: 5},
      %Fatura.Conta{fatura: "Agua", vencimento: 10},
      %Fatura.Conta{fatura: "Luz", vencimento: 5},
      %Fatura.Conta{fatura: "Luz", vencimento: 10},
      %Fatura.Conta{fatura: "Telefone", vencimento: 5},
      %Fatura.Conta{fatura: "Telefone", vencimento: 10}
    ]
  end

  test "deve verificar se existe a fatura passada como parametro" do
    faturas = Fatura.criar_fatura(["Telefone", "Agua", "Luz"], [5, 10])
    assert Fatura.fatura_existe?(faturas, %Fatura.Conta{fatura: "Telefone", vencimento: 5}) == true
  end


end
