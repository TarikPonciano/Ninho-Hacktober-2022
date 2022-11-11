import random
p1_candy=0  #quantidade de doces 
print("_________________________________")
print("Doces ou Travessuras!!")
print("_________________________________")
print("Vamos ver quantos doces conseguiremos nesse Halloween?!!")
print("_________________________________")
p1_candy=random.randint(10,25)
if p1_candy<20:
  print(p1_candy,"Bem, não foram tantos doces assim, mas conseguiremos mais na próxima.")
else:
  print(p1_candy,"Uau, quantos doces!!!")
