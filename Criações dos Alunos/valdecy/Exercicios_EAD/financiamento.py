sala = float(input('Digite o valor do salario: '))
financ = float(input('Digite o valor do financiamento pretendido: '))
print('financiamento concedido, obrigado por nos consultar'
      if financ <= 5 * sala else
      'financiamento negado, obrigado por nos consultar')
