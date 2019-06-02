defmodule IconeIdentidade do
  @moduledoc """
  Documentation for IconeIdentidade.
  """

 def main(entrada) do
   entrada
   |> hash_input
   |> criar_cor
   |> criar_tabela
   |> remover_impar
   |> constroi_pixel
   |> desenhar
   |> salvar(entrada)
 end


 def desenhar(%IconeIdentidade.Imagem{color: color, pixel_map: pixel_map}) do
   imagem = :egd.create(250, 250)
   preencha = :egd.color(color)

   Enum.each pixel_map, fn {start, stop} ->
    :egd.filledRectangle(imagem,start, stop, preencha)
   end
   :egd.render(imagem)
 end


 def criar_cor(%IconeIdentidade.Imagem{hex: [r, g, b | _tail]} = imagem) do
   %IconeIdentidade.Imagem{imagem | color: {r, g, b}}
 end


 def constroi_pixel(%IconeIdentidade.Imagem{grid: grid} = imagem) do
   pixel_map = Enum.map grid, fn {_valor, indice} ->
    h = rem(indice, 5) * 50
    v = div(indice, 5) * 50
    t_esquerda = {h, v}
    i_direita = {h+50, v+50}
    {t_esquerda, i_direita}
   end
   %IconeIdentidade.Imagem{imagem | pixel_map: pixel_map}
 end

 def criar_tabela(%IconeIdentidade.Imagem{hex: hex} = imagem) do
   grid =  hex
   |> Enum.chunk(3)
   |> Enum.map(&espelhar/1)
   |> List.flatten
   |> Enum.with_index
   %IconeIdentidade.Imagem{imagem | grid: grid}
 end


def espelhar(linha) do
  [pri, sec | _tail] = linha
  linha ++ [sec, pri]
end

def remover_impar(%IconeIdentidade.Imagem{grid: grid} = imagem) do
  new_grid = Enum.filter grid, fn {valor, _indice} ->
    rem(valor, 2) == 0
  end
  %IconeIdentidade.Imagem{imagem | grid: new_grid}
end

def hash_input(entrada) do
  hex = :crypto.hash(:md5, entrada)
  |> :binary.bin_to_list
  %IconeIdentidade.Imagem{hex: hex}
end

def salvar(imagem, entrada) do
  File.write("#{entrada}.png", imagem)
end



end
