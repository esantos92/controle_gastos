module ApplicationHelper
  def formatar_moeda(valor)
    number_to_currency(valor, unit: "R$", separator: ",", delimiter: ".")
  end

  def formatar_data(data)
    data&.strftime("%d/%m/%Y")
  end
end
