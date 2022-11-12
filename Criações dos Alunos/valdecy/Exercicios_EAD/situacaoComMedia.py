lista = []
x = 0
while x < 4:
    lista.append(float(input('Digite o valor da nota: ')))
    x += 1
media = sum(lista)/4

print(f'Aluno foi aprovado com media:{media}' if media >= 5
      else f'Aluno nao foi aprovado com media:{media}')
