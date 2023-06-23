module ApplicationHelper
  def format_cnpj(cnpj)
    "#{cnpj[0..1]}.#{cnpj[2..4]}.#{cnpj[5..7]}/#{cnpj[8..11]}-#{cnpj[12..13]}"
  end

  def format_cpf(cpf)
    "#{cpf[0..2]}.#{cpf[3..5]}.#{cpf[6..8]}-#{cpf[9..10]}"
  end
end
