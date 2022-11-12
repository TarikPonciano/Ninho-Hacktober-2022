sexo = input("Escreva o seu sexo F ou M: ")
a = float(input("Escreva sua Altura: "))
if sexo.lower() == 'f':
    p = (62.1*a) - 44.7
    print(f'Seu peso ideal é: {p}')
elif sexo.lower() == 'm':
    p = (72.7*a) - 58
    print(f'Seu peso ideal é: {p}')
else:
    print('Sexo digitado de forma errada')
