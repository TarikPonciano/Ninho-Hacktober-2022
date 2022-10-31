s=0 # salário
f=0 # financiamento
print("Digite o valor do salário:")
s=float(input())
print("Digite o valor do financiamento:")
f=float(input())
if f<=(5*s):
  print("financiamento concedido, obrigado por nos consultar.")
else:
  print("financiamento negado, obrigado por nos consultar.")
