import array as arr

# Variables
i = 0
debug = 0
new_room = 1
last_room = 1
room = "sala"
inventory = arr.array('I', [0, 0, 0, 0, 0, 0, 0, 0])
storyline_array = arr.array('I', [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
time = -1
room_list = ["sala", "quarto", "cozinha", "banheiro"]
items_list = ["nothing", "chave"]

# Functions
# check input
def get_action(id):
    global new_room
    global room
    global items_list
    global inventory
    global storyline_array
    global time
    global last_room
    command = id[0]
    if (debug == 1):
        print("DEBUG: Comando:", command)
        print("DEBUG:", room_list)
    if (command == "help"):
        print("""Comandos:
ir para:
 Vai para uma sala diferente
 Quartos Disponíveis (por agora):
  sala
  quarto
  cozinha
  banheiro
sair:
 Fecha o programa
tempo:
 Olha o tempo
inventario:
 Mostra os itens no inventário
usar:
 Usa um item disponível no inventário
voltar:
 Volta à sala anterior em que estava
""")

    if (command == "test"):
        global inventory
        i = 0
        while(i < len(inventory)):
            getItem(1)
            i += 1


    if (command == 'voltar'):
        if last_room == 1:
            print("Você ainda não foi para nenhum lugar")
        else:
            auxiliar = last_room
            last_room = room
            room = auxiliar
            new_room = 1


    if (command == "ir"):
        if (id[1] == "para"):
            if id[2] in room_list:
                last_room = room
                room = id[2]
                new_room = 1
            else:
                print("uhh... acho que não.")
        else:
            print("ir ", id[1], "... ok. Tente denovo.", sep='')

    if (command == "sair"):
        exit()

    if (command == "tempo"):
        print("Você olha o tempo...")
        s = time
        if (time < 10):
            s = "0" + str(time)
        print("São 6:", s, ". E você perdeu 1 minuto lendo isso.", sep='')

    if (command == "inventario"):
        displayInventory()

    if (command == '"inventario"'):
        if (storyline_array[15] == 1):
            print("ASSIM NÃO!!!")
        else:
            print("???")

    if (command == "olhar"):
        if (room == "sala"):
            print("A luz está apagada, e consigo somente enxergar a TV e o tapete que está sendo iluminada pela TV.")
            print("Preciso acender a luz pelo interruptor.")

    if (command == "usar"):
        #item
        if (len(id) == 1):
            print("Usar... o quê???")
        else:
            #item
            if (id[1] == "item"):
                if (len(id) <= 2):
                    print("Que item?")
                    if (storyline_array[15] == 0):
                        print('Use o comando "inventario" para exibir a lista de itens.')
                        storyline_array[15] = 1
                    else:
                        print('Comando "inventario"... lembra?')
                else:
                    # Verifique se o item existe
                    if checkItem(id[2]) != 0:
                        if (len(id) <= 3):
                            print("Usar ", id[2], "... Mas em quê?", sep='')
                        else:
                            if (id[3] == "em"):
                                if (len(id) <= 4):
                                    print("boa ideia! vou usar em nada. Tente denovo.")
                                else:
                                    # room dependant actions
                                    if (room == "sala"):
                                        # usar chave
                                        if (id[2] == "chave"):
                                            if (id[4] == "porta"):
                                                if (storyline_array[0] == 2): 
                                                    print("Se eu tentar destrancar outra vez, a chave pode quebrar dentro da tranca... É... Não vamos fazer isso.")
                                                if (storyline_array[0] == 1): 
                                                    print("Agora a porta realmente foi destrancada.")
                                                    storyline_array[0] = 2
                                                if (storyline_array[0] == 0):
                                                    storyline_array[0] = 1
                                                    print("A porta foi destrancada!")
                                                useItem(1)
                                            elif (id[4] == "tapete"):
                                                print("Infelizmente isso não é um meio de transporte. Bem que poderia ser.")
                                            else:
                                                print("Não posso usar isso aqui.")
                    else:
                        print("Eu não tenho esse item!")
            
            #room dependant actions
            if (room == "sala"):
                if (id[1] == "tapete"):
                    if (storyline_array[0] < 2):
                        if (storyline_array[10] == 2):
                            print("Claro que não fui eu que fiz isso. Confia...")

                        if (storyline_array[10] == 1):
                            if (storyline_array[8] == 0):
                                print("Tento o meu máximo para tentar enxergar se tem algo no tapete... E achei... poeira.  Muita poeira debaixo do tapete...")
                            else:
                                print("huh? muita poeira embaixo do tapete?!? Não tinha visto isso antes.")
                            storyline_array[10] = 2

                        if (storyline_array[10] == 0):
                            if (storyline_array[8] == 0):
                                print("Tento o meu máximo para tentar enxergar se tem algo no tapete... E achei... uma chave. Isso mesmo.")
                                storyline_array[10] = 1
                            else:
                                print("Levantei o tapete e achei uma chave! E muita poeira...")
                                storyline_array[10] = 2
                            
                            print("Agora, como isso foi parar ali? Escondendo a chave reserva? Mas isso não era pra estar em um local bem escondido... NO LADO DE FORA???")
                            getItem(1)
                    else:
                        print("Limpo isso depois...")

                if (id[1] == "porta"):
                    if (storyline_array[0] == 0):
                        print("Está trancada... Preciso de uma chave.")
                    if (storyline_array[0] == 1):
                        print("Lembrei que dei duas voltas na tranca... Oops!")
                    if (storyline_array[0] == 2):
                        print("Consegui sair a tempo em", time, "minutos")
                        exit()

                if (id[1] == "interruptor"):
                    if (storyline_array[8] == 0):
                        print("Click! A luz acende.")
                        storyline_array[8] = 1
                    else:
                        print("Não tenho medo do escuro, mas vamos deixar acesa por enquanto.")

    # Action ended, go back to input mode.
    inputMode()

# get player input
def inputMode():
    global time
    time += 1
    if (time >= 60):
        print("Você não consegue sair a tempo... O que aconteceu depois? Não sei.")
        exit()

    global room
    global new_room
    if (debug == 1):
        print("DEBUG: new room?", new_room)
    if new_room == 1:
        print("Você agora está em:", room)
        new_room = 0
    print("")
    print("o que fazer?")
    user_input = input("")

    get_action(user_input.split())

def displayInventory():
    storyline_array[15] = 1
    if (inventory[0] == 0):
        print("Tenho nada no inventário!")
    else:
        print("Inventário:")
        i = 0
        while i < len(inventory):
            if inventory[i] != 0:
                print(items_list[inventory[i]])
            i += 1

def checkItem(item):
    global inventory
    global items_list
    slot_id = 0
    if item in items_list:
        item = items_list.index(item)
    else:
        return 0

    if (debug == 1):
        print("DEBUG: Checking for item with ID ", item, "...", sep='')
    
    haveit = 0
    i = 0
    while ((i < len(inventory)) and haveit == 0):
        if (inventory[i] == item):
            haveit = 1
            slot_id = i
        i += 1
    return haveit
    #return [haveit, slot_id]

# use the first item it finds in the inventory of given id 
def useItem(item_id):
    global inventory
    used = 0
    i = 0
    while ((i < len(inventory)) and used == 0):
        if (inventory[i] == item_id):
            inventory[i] = 0
            used = 1
            sortItems()
        i += 1
    

def getItem(item_id):
    if (debug == 1):
        print("entered getItem() function")
    global inventory
    inserted = 0
    i = 0
    while ((i < len(inventory)) and inserted == 0):
        if (inventory[i] == 0):
            inventory[i] = item_id
            return
        i += 1
    
    if (inserted == 0):
        print("Sem espaço no inventário!")


def sortItems():
    global inventory
    i = 1
    while(i < len(inventory)):
        # check if previous slot is empty
        if (inventory[i-1] == 0):
            # move item to previous slot
            inventory[i-1] = inventory[i]
            # empty out old slot
            inventory[i] = 0
        i += 1


# game start

print("(insira uma intro para uma história aqui)")
print("Por agora, tem uma porta trancada na sala.")
print('Digite "help" para visualizar comandos disponíveis')
inputMode()



# 300 lines :O
