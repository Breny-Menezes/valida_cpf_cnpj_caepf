class ValidaCpfCnpjCaepf

  puts "Selecione uma opção: "
  puts "1 - Validar CPF"
  puts "2 - Validar CNPJ"
  puts "3 - Validar CAEPF"
  puts "4 - Fechar"

  while tipo_de_documento = gets.chomp
    break if tipo_de_documento == "4"

    puts "Digite o número do Documento: "
    documento = gets.chomp

    case tipo_de_documento
    when "1"
      #CPF: Regra do DV se o resto for menor que 2 ele vira zero, senão é 11 menos o resto da divisão
      if documento.to_s.gsub(".", "").gsub("-", "").gsub("/", "").size == 11
        a1, a2, a3, a4, a5, a6, a7, a8, a9 = documento.to_s.gsub(".", "").gsub("-", "").gsub("/", "").split("").map(&:to_i)

        digito_verificador_1 = ((a1 * 10) + (a2 * 9) + (a3 * 8) + (a4 * 7) + (a5 * 6) + (a6 * 5) + (a7 * 4) + (a8 * 3) + (a9 * 2)) % 11
        digito_verificador_1 = digito_verificador_1 < 2 ? 0 : (11 - digito_verificador_1)

        digito_verificador_2 = ((a1 * 11) + (a2 * 10) + (a3 * 9) + (a4 * 8) + (a5 * 7) + (a6 * 6) + (a7 * 5) + (a8 * 4) + (a9 * 3) + (digito_verificador_1 * 2)) % 11
        digito_verificador_2 = digito_verificador_2 < 2 ? 0 : (11 - digito_verificador_2)        

        digitos_verificadores = "#{digito_verificador_1}#{digito_verificador_2}"

        cpf_valido = documento.to_s.gsub(".", "").gsub("-", "").gsub("/", "").slice(0..8) + digitos_verificadores.to_s.rjust(2, "0")

        if cpf_valido == documento.to_s.gsub(".", "").gsub("-", "").gsub("/", "")
          puts "CPF Válido!!"
        else
          puts "CPF Inválido."
        end
      else
        puts "CPF Inválido. O Documento deve possuir 11 Dígitos."
      end
    when "2"
      #CNPJ: Regra do DV se o resto for menor que 2 ele vira zero, senão é 11 menos o resto da divisão
      if documento.to_s.gsub(".", "").gsub("-", "").gsub("/", "").size == 14
        a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12 = documento.to_s.gsub(".", "").gsub("-", "").gsub("/", "").split("").map(&:to_i)

        digito_verificador_1 = ((a1 * 5) + (a2 * 4) + (a3 * 3) + (a4 * 2) + (a5 * 9) + (a6 * 8) + (a7 * 7) + (a8 * 6) + (a9 * 5) + (a10 * 4) + (a11 * 3) + (a12 * 2)) % 11
        digito_verificador_1 = digito_verificador_1 < 2 ? 0 : (11 - digito_verificador_1)

        digito_verificador_2 = ((a1 * 6) + (a2 * 5) + (a3 * 4) + (a4 * 3) + (a5 * 2) + (a6 * 9) + (a7 * 8) + (a8 * 7) + (a9 * 6) + (a10 * 5) + (a11 * 4) + (a12 * 3)+ (digito_verificador_1 * 2)) % 11
        digito_verificador_2 = digito_verificador_2 < 2 ? 0 : (11 - digito_verificador_2)        

        digitos_verificadores = "#{digito_verificador_1}#{digito_verificador_2}"

        cnpj_valido = documento.to_s.gsub(".", "").gsub("-", "").gsub("/", "").slice(0..11) + digitos_verificadores.to_s.rjust(2, "0")

        if cnpj_valido == documento.to_s.gsub(".", "").gsub("-", "").gsub("/", "")
          puts "CNPJ Válido!!"
        else
          puts "CNPJ Inválido."
        end
      else
        puts "CNPJ Inválido. O Documento deve possuir 14 Dígitos."
      end
    when "3"
      #CAEPF: Regra do DV se o resto 10, ele vira zero. Se a dupla de digitos for maior que 99 deve ser os digitos menos 100.
      if documento.to_s.gsub(".", "").gsub("-", "").gsub("/", "").size == 14
        a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12 = documento.to_s.gsub(".", "").gsub("-", "").gsub("/", "").split("").map(&:to_i)

        digito_verificador_1 = ((a1 * 6) + (a2 * 7) + (a3 * 8) + (a4 * 9) + (a5 * 2) + (a6 * 3) + (a7 * 4) + (a8 * 5) + (a9 * 6) + (a10 * 7) + (a11 * 8) + (a12 * 9)) % 11
        digito_verificador_1 = 0 if digito_verificador_1 == 10

        digito_verificador_2 = ((a1 * 5) + (a2 * 6) + (a3 * 7) + (a4 * 8) + (a5 * 9) + (a6 * 2) + (a7 * 3) + (a8 * 4) + (a9 * 5) + (a10 * 6) + (a11 * 7) + (a12 * 8)+ (digito_verificador_1 * 9)) % 11

        digitos_verificadores = "#{digito_verificador_1}#{digito_verificador_2}".to_i + 12
        digitos_verificadores = digitos_verificadores - 100 if digitos_verificadores > 99

        caepf_valido = documento.to_s.gsub(".", "").gsub("-", "").gsub("/", "").slice(0..11) + digitos_verificadores.to_s.rjust(2, "0")

        if caepf_valido == documento.to_s.gsub(".", "").gsub("-", "").gsub("/", "")
          puts "CAEPF Válido!!"
        else
          puts "CAEPF Inválido."
        end
      else
        puts "CAEPF Inválido. O Documento deve possuir 14 Dígitos."
      end
    else
      puts "Seleção Inválida! Tente Novamente."
    end

    puts "Selecione uma opção: "
    puts "1 - Validar CPF"
    puts "2 - Validar CNPJ"
    puts "3 - Validar CAEPF"
    puts "4 - Cancelar"
  end


end