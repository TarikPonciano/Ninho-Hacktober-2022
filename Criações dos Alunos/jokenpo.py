from time import sleep
from random import randint
lista = ('PEDRA', 'PAPEL','TESOURA')
pc = randint(0,2)
loop = 'S'
while loop == 'S':
  print('''
[0] PEDRA 
[1] PAPEL
[2] TESOURA
''')
  jogador = int(input('Digite o valor de sua escolha: '))
  print('JO')
  sleep(1)
  print('KENNN')
  sleep(1)
  print('POOOOOOOOO')
  print('-=' * 15)
  print('O Computador escolheu: {}'.format(lista[pc]))
  print('O Jogador escolheu: {}'.format(lista[jogador]))
  print('-=' * 15)
  if pc == 0: 
    if jogador == 0: 
      print('DEU EMPATE!')
    elif jogador == 1:
      print('JOGADOR VENCEU!')
    elif jogador == 2:
      print('COMPUTADOR VENCEU!')
  if pc == 1: 
    if jogador == 0:
      print('COMPUTADOR VENCEU!')
    elif jogador == 1:
      print('DEU EMPATE!')
    elif jogador == 2:
      print('JOGADOR VENCEU!')
  if pc == 2:
    if jogador == 0: 
      print('JOGADOR VENCEU!')
    elif jogador == 1:
      print('COMPUTADOR VENCEU!')
    elif jogador == 2:
      print('DEU EMPATE!')
  loop = str(input('Deseja jogar novamente? [S/N]').upper())
print('FIM')
