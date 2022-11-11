from platform import system
from os import system as st


def limpar():
    if system() == 'Linux':
        st('clear')
    elif system() == 'Windows':
        st('cls')


def mostrar(func):
    print(func.__doc__)
    input('Aperte Enter para continuar')
    limpar()


def questao1():
    '''Questao 1: Faça um algoritmo que leia os valores A, B, C
e imprima na tela se a soma de A + B é menor que C.'''
    a = int(input('Digite o valor de a: '))
    b = int(input('Digite o valor de b: '))
    c = int(input('Digite o valor de c: '))

    if a+b < c:
        print('valor de a + b é menor que c')
    elif a+b == c:
        print('valor de a + b é igual a c')
    else:
        print('valor de a + b é maior que c')

    input('Aperte Enter para continuar')
    limpar()


def questao2():
    '''Questao2: Faça um algoritmo para receber um número qualquer e
informar na tela se é par ou ímpar.'''
    x = int(input('digite um numero: '))
    if x % 2 == 0:
        print(f'{x} é par')
    else:
        print(f'{x} é impar')
    input('Aperte Enter para continuar')
    limpar()


def questao3():
    '''Questao 3: Faça um algoritmo que leia dois valores inteiros A e B se os valores
forem iguais deverá somar os dois, caso contrário multiplique A por B.
Ao final de qualquer um dos cálculos deve-se atribuir o resultado para
uma variável C e mostrar seu conteúdo na tela.'''
    a = int(input('Digite o valor de A: '))
    b = int(input('Digite o valor de B: '))
    if a == b:
        c = a + b
    else:
        c = a * b
    print(c)
    input('Aperte Enter para continuar')
    limpar()


def questao4():
    '''Questao 4: Escreva um algoritmo que leia três valores inteiros e diferentes
e mostre-os em ordem decrescente.'''
    list = []
    x = 0
    while x < 3:
        list.append(int(input('Digite o valor de um numero inteiro: ')))
        x += 1
    list.sort(reverse=True)
    print(list)
    input('Aperte Enter para continuar')
    limpar()


def questao5():
    '''Questao 5: Escrever um algoritmo que leia o nome e as três notas obtidas por um
aluno durante o semestre. Calcular a sua média (aritmética),
informar o nome e sua menção aprovado (media >= 7),
Reprovado (media <= 5) e Recuperação (media entre 5.1 a 6.9)'''
    aluno = input('Digite o nome do Aluno: ')
    nota1 = float(input('Digite a primeira nota: '))
    nota2 = float(input('Digite a segunda nota: '))
    nota3 = float(input('Digite a terceira nota: '))

    media = (nota1 + nota2 + nota3)/3
    if media >= 7:
        print(f'{aluno} aprovado')
    elif media > 5 and media < 6:
        print(f'{aluno} de recuperacao')
    else:
        print(f'{aluno} reprovado')
    input('Aperte Enter para continuar')
    limpar()


def questao6():
    '''Questao 6: O cardápio de uma lanchonete é o seguinte:
        Especificação                       Preço unitário
        100 Cachorro quente                     1,10
        101 Bauru simples                       1,30
        102 Bauru c/ovo                         1,50
        103 Hamburger                           1,10
        104 Cheeseburger                        1,30
        105 Refrigerante                        1,00
Escrever um algoritmo que leia o código do item pedido, a quantidade e
calcule o valor a ser pago por aquele lanche. Considere que a cada
execução somente será calculado um item.'''
    cardapio = {100: 1.1, 101: 1.3, 102: 1.5, 103: 1.1, 104: 1.3, 105: 1.00}
    codigo = int(input('Digite o codigo do produto: '))
    quantidade = int(input('Digite a quantidade do item pedido: '))
    valorPago = cardapio[codigo] * quantidade
    print(f'Valor a pagar e: {valorPago} reais')
    input('Aperte Enter para continuar')
    limpar()


def questao7():
    '''Questao 7: Calcule a tabuada do 13.'''
    for n in range(11):
        print(f'{n} x 13 = {n*13}')
    input('Aperte Enter para continuar')
    limpar()


def questao8():
    '''Questao 8: Ler do teclado 10 números e imprima a
quantidade de números entre 10 e 50.'''
    x = 0
    cache = []
    count = 0
    while x < 10:
        numero = float(input('Digite um valor: '))
        if numero >= 10 and numero <= 50:
            count += 1
            cache.append(numero)
        x += 1
    print(f'Quantidade de numeros entre 10 e 50 é: {count}, e os numeros são:{cache}')
    input('Aperte Enter para continuar')
    limpar()


def questao9():
    '''Questao 9: Ler do teclado uma lista com 5 inteiros e imprimir o menor valor.'''
    list = []
    x = 0
    while x < 5:
        list.append(int(input('Digite um numero inteiro: ')))
        x += 1
    list.sort()
    print(list[0])
    input('Aperte Enter para continuar')
    limpar()


def questao10():
    '''Questao 10: Calcule o somatório dos números de 1 a 100 e imprima o resultado.'''
    soma = 0
    for n in range(101):
        soma += n
    print(soma)
    input('Aperte Enter para continuar')
    limpar()


def questao11():
    '''Questao 11: Receba dois números inteiros correspondentes à largura e altura.
Devolva uma cadeia de caracteres # que representa um retângulo
com as medidas fornecidas.\n'''
    width = int(input('Digite a largura: '))
    height = int(input('Digite a altura: '))
    x = 0
    print('#'*width)
    a = ('#'+' '*(width - 2)+'#')
    while (x < (height - 2)):
        print(a)
        x += 1
    print('#'*width)
    input('Aperte Enter para continuar')
    limpar()


def questao12():
    '''Questao 12: Ler do teclado um número inteiro e imprimir se ele é primo ou não.'''
    flag = True
    numero = int(input('Digite um numero inteiro: '))
    for n in range(2, (int(numero/2)+1)):
        if numero % n == 0:
            print(f'{numero} nao é primo')
            flag = False
            break
    if flag:
        print(f'{numero} e primo')
    input('Aperte Enter para continuar')
    limpar()


def main():
    limpar()
    mostrar(questao1)
    questao1()
    mostrar(questao2)
    questao2()
    mostrar(questao3)
    questao3()
    mostrar(questao4)
    questao4()
    mostrar(questao5)
    questao5()
    mostrar(questao6)
    questao6()
    mostrar(questao7)
    questao7()
    mostrar(questao8)
    questao8()
    mostrar(questao9)
    questao9()
    mostrar(questao10)
    questao10()
    mostrar(questao11)
    questao11()
    mostrar(questao12)
    questao12()


if __name__ == '__main__':
    main()
