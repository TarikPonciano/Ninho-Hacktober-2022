maior = None
n = float(input('Digite um numero positivo maior que 0: '))
while n != 0:
    if maior is None:
        maior = n
        n = float(input('Digite outro valor: '))
        if n > maior:
            maior = n
    else:
        print(f'maior valor é: {maior}')
        n = float(input('Digite um numero positivo maior que 0: '))
        if n > maior:
            maior = n
