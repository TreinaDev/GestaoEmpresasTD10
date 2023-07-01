module ApplicationHelper
  def format_cnpj(cnpj)
    "#{cnpj[0..1]}.#{cnpj[2..4]}.#{cnpj[5..7]}/#{cnpj[8..11]}-#{cnpj[12..13]}"
  end

  def format_cpf(cpf)
    "#{cpf[0..2]}.#{cpf[3..5]}.#{cpf[6..8]}-#{cpf[9..10]}"
  end

  def format_number(phone)
    "(#{phone[0..1]}) #{phone[2..6]}-#{phone[7..]}"
  end

  def format_name(name)
    return current_user.email if name.nil?
    lowercase_words = %w[de da do das dos]
    titleized_name = name&.split(' ')&.map do |word|
      if lowercase_words.include?(word.downcase)
        word.downcase
      else
        word.capitalize
      end
    end
    titleized_name.join(' ')
  end
end
