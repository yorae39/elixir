defmodule FaturaTest do
  use ExUnit.Case
  doctest Fatura

  test "deve criar uma lista de faturas" do
    faturas = Fatura.criar_fatura(["Telefone", "Agua", "Luz"], [5, 10])
    assert faturas == ["Fatura: Telefone vence no dia: 5", "Fatura: Agua vence no dia: 5",
    "Fatura: Luz vence no dia: 5", "Fatura: Telefone vence no dia: 10",
    "Fatura: Agua vence no dia: 10", "Fatura: Luz vence no dia: 10"]
  end

  test "deve ordenar uma lista de faturas " do
    faturas = Fatura.criar_fatura(["Telefone", "Agua", "Luz"], [5, 10])
    assert Fatura.ordena_fatura(faturas) == ["Fatura: Agua vence no dia: 10", "Fatura: Agua vence no dia: 5",
    "Fatura: Luz vence no dia: 10", "Fatura: Luz vence no dia: 5",
    "Fatura: Telefone vence no dia: 10", "Fatura: Telefone vence no dia: 5"]
  end

  test "deve verificar se existe a fatura passada como parametro" do
    assert Fatura.fatura_existe?(Fatura.criar_fatura(["Telefone", "Agua", "Luz"], [5, 10]), "Fatura: Agua vence no dia: 10") == true
  end


end
