print ("Histórias Infantis Interativas")

resposta = input ("Você quer conhecer uma história? (sim/não) ")
if resposta.lower().strip() == "não":
    print("Que pena!")
    quit()

if resposta.lower().strip() == "sim":
    resposta = input ("Vamos começar. A mãe da chapeuzinho pediu para ela ir deixar doce na vovozinha que estava doente. - Você pode ir chapeuzinho? Ela responder: (sim/não) ")

if resposta.lower().strip() == "não":
    print  ("Chapeuzinho não cuidou sua vovozinha. Perdeu sua capa vermelha")
    quit ()

if resposta.lower().strip() == "sim":
    resposta = input("Sua mãe falou: Não saia do caminho e vá direto para casa de sua avó, sem parar para falar com nenhum estranho. Chapeuzinho entrou na floresta, logo apareceu um lobo atrás da árvore. O lobo falou: Bom dia, Chapeuzinho. (responder/correr) ")

if resposta.lower().strip() == "correr":
    print ("Chapeuzinho chegou na casa vovozinha com tranquilidade")
    quit()

if resposta.lower().strip() == "responder":
    resposta = input("Bom dia, Senhor Lobo. - Ela respondeu. O Lobo perguntou: Para onde você vai? Para casa da vovó deixar esses doces. Excelente! E onde sua vovozinha mora? - Perguntou o lobo. (correr/responder) ")

if resposta.lower().strip() == "correr":
    print ("Chapeuzinho foi embora tranquilamente para a casa vovozinha")
    quit ()

if resposta.lower().strip() == "responder":
    resposta = input ("Chapeuzinho explicou exatamente o local da casa da sua avó! Eles seguiram juntos. Então o Lobo falou: - Olha que lindas flores que temos aqui! Por que você não pega algumas para sua vovó? (sair/pegar) ")

if resposta.lower().strip() =="sair":
    print ("Chapeuzinho continuou sozinha e chegou segura na vovó")
    quit()

if resposta.lower().strip() == "pegar":
    resposta = input ("Chapauzinho pegando as flores desviou do caminho. Aproveitando o Lobo foi direto para casa da vovó. Assim ele chegou, bateu na porta. - Quem é? perguntou a vovó. - Sou eu a chapeuzinho. Falou o lobo enganando a vovó. Entaão a vovó ouviu o Lobo e respondeu: (saia/entre) ")

if resposta.lower().strip() == "saia":
    print ("Um caçador passou próximo ouviu o grito da Vovó mandando o lobo embora. Agindo rápido o caçador foi atrás do lobo e conseguiu capturar o lobo malvado. Chapeuzinho depois chegou em segurança na vovó")
    quit ()

if resposta.lower().strip() == "entre":
    resposta = input ("O lobo entrou na casa, e prendeu a vovó no armário! Em seguida, ele vestiu as roupas dela para enganar chapeuzinho que logo chegou. A porta estava aberta chapeuzinho entrou e achou aparência da vovó esquisita... (sair/perguntar) ")

if resposta.lower().strip() == "sair":
    print ("Chapuzinho encontrou o caçador e falou que tinha algo estranho na casa vovó. O caçador foi verificar e logo percebeu que nao era a vovó na cama. Ele capturou o lobo e resgatou a vovó. Deixando todos seguro")
    quit ()

if resposta.lower().strip() == "perguntar":
    resposta = input ("Vóvó que orelhas grandes você tem. É para ti ouvir melhor! - O lobo respondeu. - Puxa, vovó, que olhos grandes você tem! Para tiver melhor minha netinha. Nossa vovó que boca enorme! -É para te devorar! - Gritou o lobo num salto da cama para pegar chapeuzinho. (ficar/correr) ")

if resposta.lower().strip() == "ficar":
    print ("Lobo consegue capturar chapeuzinho. Fim do JOGO")
    quit ()

if resposta.lower().strip() == "correr":
    resposta = input ("Chapauzinho fugiu pela porta. O lobo foi atrás. Um caçador que passava por perto, escutou a gritaria. Viu o Lobo e consegui capturar. Chapeuzinho agradeceu o caçador e falou que sua vovó tinha sumido. O caçador obrigou o lobo falar onde estava a vovozinha. O lobo contou tudo e chapeuzinho voltou para casa da vovó para solta-la. Chapeuzinho entregou os doces sua vovó. (sair/mais) ")

if resposta.lower().strip() == "sair":
    print ("Obrigada por ajudar a conta a história")
    exit()

if resposta.lower().strip() == "mais":
    print ("Chapeuzinho aprendeu nunca mais sair do caminho e escutar com mais atenção tudo o que sua mãe falar para ela. Obrigada por ajudar a conta esse história")
    quit ()
