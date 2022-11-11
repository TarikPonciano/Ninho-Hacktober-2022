from random import randint
s = 0
placarJ = 0
placarPC = 0
while True:
  jogador = str(input('Vamos jogar Par ou Ímpar? Digite qual a sua escolha: [P/I]: ').upper())
  n = int(input(' Digite um número de 0 à 10: '))
  pc = randint(0, 10)
  s = pc + n
  if s % 2 == 0:
    if jogador == 'P':
      print('=' * 50)
      print(f'O PC escolheu {pc} e você escolheu {n}. O resultado foi {s}! Deu PAR! Parabéns você venceu essa rodada!')
      placarJ += 1
      print('=' * 50)
    else:
      placarPC += 1
      print('=' * 50)
      print(f'O PC escolheu {pc} e você escolheu {n}. O resultado foi {s}! Deu PAR! Que Pena, você perdeu! O placar final foi {placarPC} x {placarJ}')
      print('=' * 50)
      break
  if s % 2 != 0: 
    if jogador == 'I':
        print('=' * 50)
        print(f'O PC escolheu {pc} e você escolheu {n}. O resultado foi {s}! Deu ÍMPAR! Parabéns você venceu essa rodada!')
        placarJ += 1
        print('=' * 50)
    else:
        placarPC += 1
        print('=' * 50)
        print(f'O PC escolheu {pc} e você escolheu {n}. O resultado foi {s}! Deu ÍMPAR! Que Pena, você perdeu! O placar final foi {placarPC} x {placarJ}')
        print('=' * 50)
        break
    
