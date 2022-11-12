lista, x = [], 0
while x < 5:
    lista.append(float(input('Digite uma nota: ')))
    x += 1
media = sum(lista)/5
print(f'A soma das notas é: {sum(lista)}')
print(f'A soma das medias é: {media}')
print('Os valores maiores que a media são:')
for n in lista:
    if n > media:
        print(n)
